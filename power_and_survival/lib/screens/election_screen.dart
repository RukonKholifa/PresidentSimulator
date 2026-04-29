import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../models/game_state.dart';
import '../managers/election_manager.dart';

class ElectionScreen extends StatefulWidget {
  const ElectionScreen({super.key});

  @override
  State<ElectionScreen> createState() => _ElectionScreenState();
}

class _ElectionScreenState extends State<ElectionScreen> {
  late GameState state;
  bool _initialized = false;
  double? _result;
  bool? _won;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      state = ModalRoute.of(context)?.settings.arguments as GameState? ?? GameState.empty();
      _initialized = true;
    }
  }

  void _runElection() {
    final manager = ElectionManager();
    final result = manager.runElection(state);
    setState(() {
      _result = result.playerScore;
      _won = result.playerWins;
    });
    if (!result.playerWins) {
      state.isGameOver = true;
      state.gameOverReason = 'Lost the election with ${result.playerScore.toStringAsFixed(1)}% of the vote.';
    } else {
      state.currentTerm++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Election Day')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.how_to_vote, size: 60, color: AppTheme.accent),
              const SizedBox(height: 20),
              Text('General Election', style: AppTheme.headerStyle(size: 24)),
              const SizedBox(height: 8),
              Text('Term ${state.currentTerm}', style: AppTheme.bodyStyle(size: 14, color: AppTheme.textSecondary)),
              const SizedBox(height: 30),
              if (_result == null) ...[
                ElevatedButton(
                  onPressed: _runElection,
                  child: const Text('Hold Election'),
                ),
              ] else ...[
                Text(
                  '${_result!.toStringAsFixed(1)}%',
                  style: AppTheme.headerStyle(size: 48).copyWith(color: _won! ? AppTheme.success : AppTheme.danger),
                ),
                const SizedBox(height: 8),
                Text(
                  _won! ? 'VICTORY — You have been re-elected!' : 'DEFEAT — The people have spoken.',
                  style: AppTheme.bodyStyle(size: 14, color: _won! ? AppTheme.success : AppTheme.danger),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_won!) {
                      Navigator.pushReplacementNamed(context, AppRoutes.dashboard, arguments: state);
                    } else {
                      Navigator.pushReplacementNamed(context, AppRoutes.gameOver, arguments: state);
                    }
                  },
                  child: Text(_won! ? 'Continue' : 'View Results'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

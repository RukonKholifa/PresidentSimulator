import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';
import '../managers/election_manager.dart';

class ElectionScreen extends StatefulWidget {
  const ElectionScreen({super.key});

  @override
  State<ElectionScreen> createState() => _ElectionScreenState();
}

class _ElectionScreenState extends State<ElectionScreen> {
  ElectionResult? _result;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_result == null) {
      final state = ModalRoute.of(context)?.settings.arguments as GameState?;
      if (state != null) {
        final manager = ElectionManager();
        _result = manager.runElection(state);
        if (_result!.playerWins) {
          state.currentTerm++;
        } else {
          state.isGameOver = true;
          state.gameOverReason = 'election_loss';
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null || _result == null) return const Scaffold(body: Center(child: Text('Error')));

    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _result!.playerWins ? Icons.emoji_events : Icons.sentiment_dissatisfied,
                  size: 80,
                  color: _result!.playerWins ? AppTheme.gold : AppTheme.danger,
                ).animate().scale(duration: 600.ms),
                const SizedBox(height: 24),
                Text(
                  StringsEn.electionDay,
                  style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                ).animate().fadeIn(delay: 300.ms),
                const SizedBox(height: 8),
                Text(
                  _result!.playerWins ? StringsEn.youWon : StringsEn.youLost,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: _result!.playerWins ? AppTheme.gold : AppTheme.danger,
                  ),
                ).animate().fadeIn(delay: 500.ms),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _scoreCard('You', _result!.playerScore, _result!.playerWins),
                    const SizedBox(width: 24),
                    _scoreCard('Opponent', _result!.opponentScore, !_result!.playerWins),
                  ],
                ).animate().fadeIn(delay: 800.ms),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      _result!.narrative,
                      style: const TextStyle(fontSize: 14, height: 1.5, color: AppTheme.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ).animate().fadeIn(delay: 1000.ms),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_result!.playerWins) {
                        Navigator.pushReplacementNamed(context, AppRoutes.dashboard, arguments: state);
                      } else {
                        state.currentLegacyEnding = 'peaceful_transition';
                        Navigator.pushReplacementNamed(context, AppRoutes.gameOver, arguments: state);
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accent, padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: Text(_result!.playerWins ? StringsEn.continueGoverning : 'View Legacy'),
                  ),
                ).animate().fadeIn(delay: 1200.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _scoreCard(String label, double score, bool isWinner) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: AppTheme.textSecondary)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isWinner ? AppTheme.gold.withValues(alpha: 0.1) : AppTheme.cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isWinner ? AppTheme.gold : AppTheme.primaryLight),
          ),
          child: Text(
            '${score.toStringAsFixed(1)}%',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isWinner ? AppTheme.gold : AppTheme.textSecondary),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../models/game_state.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.dangerous, size: 64, color: AppTheme.danger),
              const SizedBox(height: 20),
              Text('GAME OVER', style: AppTheme.headerStyle(size: 32).copyWith(color: AppTheme.danger)),
              const SizedBox(height: 12),
              if (state?.gameOverReason != null)
                Text(state!.gameOverReason!, style: AppTheme.bodyStyle(size: 14), textAlign: TextAlign.center),
              const SizedBox(height: 12),
              if (state != null) ...[
                Text('${state.presidentName} served ${state.currentMonth} months.',
                  style: AppTheme.bodyStyle(size: 12, color: AppTheme.textSecondary)),
                const SizedBox(height: 6),
                Text('Final Approval: ${state.stats.approvalRating.toStringAsFixed(1)}%',
                  style: AppTheme.bodyStyle(size: 12, color: AppTheme.textSecondary)),
              ],
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.legacy, arguments: state),
                child: const Text('View Legacy'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainMenu, (_) => false),
                child: const Text('Main Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

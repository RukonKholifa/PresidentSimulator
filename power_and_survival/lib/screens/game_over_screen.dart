import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';
import '../managers/save_manager.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final reasonTexts = {
      'bankruptcy': StringsEn.gameOverBankruptcy,
      'stability_collapse': StringsEn.gameOverStability,
      'revolution': StringsEn.gameOverRevolution,
      'corruption': StringsEn.gameOverCorruption,
      'coup': StringsEn.gameOverCoup,
      'impeachment': StringsEn.gameOverImpeachment,
      'election_loss': 'You lost the election and must leave office.',
    };

    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.dangerous, size: 80, color: AppTheme.danger)
                    .animate().scale(duration: 600.ms),
                const SizedBox(height: 24),
                const Text(StringsEn.gameOver, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.danger))
                    .animate().fadeIn(delay: 400.ms),
                const SizedBox(height: 16),
                Text(
                  reasonTexts[state.gameOverReason] ?? 'Your presidency has ended.',
                  style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary, height: 1.5),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 600.ms),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(StringsEn.finalStats, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const Divider(),
                        _statRow('Months in Office', '${state.currentMonth}'),
                        _statRow('Final Approval', '${state.stats.approvalRating.toStringAsFixed(0)}%'),
                        _statRow('Economy', state.stats.economy.toStringAsFixed(0)),
                        _statRow('Treasury', '\$${state.stats.treasury.toStringAsFixed(0)}M'),
                        _statRow('Achievements', '${state.earnedAchievements.length}'),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 800.ms),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (state.currentLegacyEnding != null) {
                        Navigator.pushReplacementNamed(context, AppRoutes.legacy, arguments: state);
                      } else {
                        Navigator.pushReplacementNamed(context, AppRoutes.mainMenu);
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accent),
                    child: const Text('View Legacy'),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await SaveManager().saveToHallOfFame({
                        'name': state.presidentName,
                        'country': state.countryName,
                        'months': state.currentMonth,
                        'approval': state.stats.approvalRating,
                        'score': state.stats.approvalRating + state.currentMonth,
                        'ending': state.gameOverReason ?? 'unknown',
                      });
                      await SaveManager().deleteSave();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(context, AppRoutes.mainMenu);
                      }
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryMid),
                    child: const Text(StringsEn.saveToHallOfFame),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppTheme.textSecondary)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

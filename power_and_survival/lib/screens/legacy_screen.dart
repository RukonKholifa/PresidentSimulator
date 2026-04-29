import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';
import '../data/endings_data.dart';
import '../managers/save_manager.dart';

class LegacyScreen extends StatelessWidget {
  const LegacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final endingId = state.currentLegacyEnding ?? 'peaceful_transition';
    final ending = EndingsData.getEndingById(endingId);
    final title = ending?['title'] ?? 'Your Legacy';
    final text = ending?['text'] ?? 'Your presidency has come to an end.';

    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const Icon(Icons.auto_stories, size: 60, color: AppTheme.gold)
                  .animate().fadeIn(duration: 800.ms),
              const SizedBox(height: 16),
              Text(StringsEn.legacy, style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary))
                  .animate().fadeIn(delay: 300.ms),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.gold), textAlign: TextAlign.center)
                  .animate().fadeIn(delay: 500.ms),
              const SizedBox(height: 24),
              Text(text, style: const TextStyle(fontSize: 14, height: 1.8, color: AppTheme.textSecondary), textAlign: TextAlign.center)
                  .animate().fadeIn(delay: 800.ms),
              const SizedBox(height: 32),
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
                      'ending': endingId,
                    });
                    await SaveManager().deleteSave();
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, AppRoutes.mainMenu);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accent, padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text(StringsEn.mainMenu),
                ),
              ).animate().fadeIn(delay: 1200.ms),
            ],
          ),
        ),
      ),
    );
  }
}

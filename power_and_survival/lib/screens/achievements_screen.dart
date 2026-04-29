import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../data/achievements_data.dart';
import '../managers/save_manager.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final unlocked = SaveManager().loadAchievements();
    final all = AchievementsData.allAchievements;

    return Scaffold(
      appBar: AppBar(title: Text('Achievements (${unlocked.length}/${all.length})')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: all.length,
        itemBuilder: (context, i) {
          final a = all[i];
          final isUnlocked = unlocked.contains(a.id);

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: isUnlocked ? AppTheme.accent : AppTheme.cardBorder),
            ),
            child: Row(
              children: [
                Icon(
                  isUnlocked ? Icons.emoji_events : Icons.lock,
                  size: 24,
                  color: isUnlocked ? AppTheme.accent : AppTheme.textSecondary,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(a.title, style: AppTheme.bodyStyle(
                        size: 13,
                        weight: FontWeight.w600,
                        color: isUnlocked ? AppTheme.textPrimary : AppTheme.textSecondary,
                      )),
                      Text(a.description, style: AppTheme.bodyStyle(size: 11, color: AppTheme.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

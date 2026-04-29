import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../data/strings_en.dart';
import '../managers/achievement_manager.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final AchievementManager _manager = AchievementManager();
  List<String> _unlocked = [];

  @override
  void initState() {
    super.initState();
    _loadAchievements();
  }

  Future<void> _loadAchievements() async {
    final unlocked = await _manager.loadUnlockedAchievements();
    if (mounted) setState(() => _unlocked = unlocked);
  }

  @override
  Widget build(BuildContext context) {
    final all = _manager.getAllAchievements();

    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.achievementsTitle)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: all.length,
        itemBuilder: (context, index) {
          final achievement = all[index];
          final isUnlocked = _unlocked.contains(achievement.id);
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            color: isUnlocked ? AppTheme.gold.withValues(alpha: 0.1) : AppTheme.cardBackground,
            child: ListTile(
              leading: Icon(
                isUnlocked ? Icons.emoji_events : Icons.lock,
                color: isUnlocked ? AppTheme.gold : AppTheme.textSecondary,
              ),
              title: Text(
                achievement.title,
                style: TextStyle(fontWeight: FontWeight.bold, color: isUnlocked ? AppTheme.gold : AppTheme.textPrimary),
              ),
              subtitle: Text(
                achievement.description,
                style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary),
              ),
              trailing: Text(
                isUnlocked ? StringsEn.unlocked : StringsEn.locked,
                style: TextStyle(fontSize: 10, color: isUnlocked ? AppTheme.success : AppTheme.textSecondary),
              ),
            ),
          );
        },
      ),
    );
  }
}

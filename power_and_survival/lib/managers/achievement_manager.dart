import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_state.dart';
import '../models/achievement.dart';
import '../data/achievements_data.dart';

class AchievementManager {
  static const String _achievementsKey = 'unlocked_achievements';

  List<String> checkAchievements(GameState state) {
    final newlyUnlocked = <String>[];

    for (final achievement in AchievementsData.allAchievements) {
      if (state.earnedAchievements.contains(achievement.id)) continue;

      if (_checkCondition(state, achievement)) {
        achievement.isUnlocked = true;
        state.earnedAchievements.add(achievement.id);
        newlyUnlocked.add(achievement.id);
      }
    }

    return newlyUnlocked;
  }

  bool _checkCondition(GameState state, Achievement achievement) {
    switch (achievement.id) {
      case 'first_term_survivor':
        return state.currentMonth >= 48 && !state.isGameOver;
      case 'reelected':
        return state.currentTerm >= 2;
      case 'economic_miracle':
        return state.stats.economy >= 90;
      case 'peoples_champion':
        return state.stats.happiness >= 90;
      case 'iron_fist':
        return state.stats.military >= 90 && state.stats.stability >= 80;
      case 'corruption_free':
        return state.stats.corruption < 10;
      case 'debt_free':
        return state.stats.debt <= 0 && state.stats.treasury > 0;
      case 'crisis_manager':
        return state.eventHistory.length >= 10;
      case 'diplomat':
        return state.stats.internationalRelations >= 90;
      case 'education_nation':
        return state.stats.education >= 90;
      case 'promise_keeper':
        return state.activePromises.isNotEmpty &&
            state.activePromises.every((p) => p.isKept);
      case 'promise_breaker':
        return state.activePromises.where((p) => p.isBroken).length >= 5;
      case 'survived_coup':
        return state.eventHistory.contains('coup_warning');
      case 'dictator_mode':
        return state.difficulty == 'dictator' && !state.isGameOver && state.currentMonth >= 48;
      case 'popularity_king':
        return state.stats.approvalRating >= 95;
      case 'wealthy_nation':
        return state.stats.treasury >= 2000;
      case 'zero_crime':
        return state.stats.crime < 10;
      case 'media_darling':
        return state.stats.mediaTrust >= 90;
      case 'all_policies':
        return state.activePolicyIds.length >= 10;
      case 'speed_run':
        return state.isGameOver && state.currentMonth <= 6;
      default:
        return false;
    }
  }

  Future<void> saveUnlockedAchievements(List<String> ids) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getStringList(_achievementsKey) ?? [];
    final combined = {...existing, ...ids}.toList();
    await prefs.setStringList(_achievementsKey, combined);
  }

  Future<List<String>> loadUnlockedAchievements() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_achievementsKey) ?? [];
  }

  List<Achievement> getAllAchievements() => AchievementsData.allAchievements;
}

import '../models/achievement.dart';

class AchievementsData {
  static List<Achievement> allAchievements = [
    Achievement(
      id: 'first_term_survivor',
      title: 'First Term Survivor',
      description: 'Complete your first 4-year presidential term without being overthrown.',
      condition: 'currentMonth >= 48 && !isGameOver',
    ),
    Achievement(
      id: 'reelected',
      title: 'Mandate Renewed',
      description: 'Win a reelection campaign and secure a second term.',
      condition: 'currentTerm >= 2',
    ),
    Achievement(
      id: 'economic_miracle',
      title: 'Economic Miracle',
      description: 'Achieve an economy rating of 90 or above.',
      condition: 'economy >= 90',
    ),
    Achievement(
      id: 'peoples_champion',
      title: 'People\'s Champion',
      description: 'Achieve a happiness rating of 90 or above.',
      condition: 'happiness >= 90',
    ),
    Achievement(
      id: 'iron_fist',
      title: 'Iron Fist',
      description: 'Achieve a military rating of 90 and stability of 80 simultaneously.',
      condition: 'military >= 90 && stability >= 80',
    ),
    Achievement(
      id: 'corruption_free',
      title: 'Corruption-Free Nation',
      description: 'Reduce corruption to below 10.',
      condition: 'corruption < 10',
    ),
    Achievement(
      id: 'debt_free',
      title: 'Debt-Free Nation',
      description: 'Pay off all national debt completely.',
      condition: 'debt <= 0 && treasury > 0',
    ),
    Achievement(
      id: 'crisis_manager',
      title: 'Crisis Manager',
      description: 'Successfully navigate 10 crisis events.',
      condition: 'crisisEventsHandled >= 10',
    ),
    Achievement(
      id: 'diplomat',
      title: 'Master Diplomat',
      description: 'Achieve international relations of 90 or above.',
      condition: 'internationalRelations >= 90',
    ),
    Achievement(
      id: 'education_nation',
      title: 'Knowledge is Power',
      description: 'Achieve an education rating of 90 or above.',
      condition: 'education >= 90',
    ),
    Achievement(
      id: 'promise_keeper',
      title: 'Promise Keeper',
      description: 'Keep all campaign promises in a single term.',
      condition: 'allPromisesKept',
    ),
    Achievement(
      id: 'promise_breaker',
      title: 'Politician\'s Promise',
      description: 'Break 5 or more campaign promises.',
      condition: 'brokenPromises >= 5',
    ),
    Achievement(
      id: 'survived_coup',
      title: 'Coup Survivor',
      description: 'Successfully prevent a military coup attempt.',
      condition: 'coupAttemptSurvived',
    ),
    Achievement(
      id: 'dictator_mode',
      title: 'Dictator',
      description: 'Win a game on Dictator difficulty.',
      condition: 'difficulty == dictator && !isGameOver',
    ),
    Achievement(
      id: 'popularity_king',
      title: 'Beloved Leader',
      description: 'Achieve an approval rating of 95 or above.',
      condition: 'approvalRating >= 95',
    ),
    Achievement(
      id: 'wealthy_nation',
      title: 'Treasury Overflow',
      description: 'Accumulate a treasury of 2000 or more.',
      condition: 'treasury >= 2000',
    ),
    Achievement(
      id: 'zero_crime',
      title: 'Safe Streets',
      description: 'Reduce crime to below 10.',
      condition: 'crime < 10',
    ),
    Achievement(
      id: 'media_darling',
      title: 'Media Darling',
      description: 'Achieve media trust of 90 or above.',
      condition: 'mediaTrust >= 90',
    ),
    Achievement(
      id: 'all_policies',
      title: 'Policy Wonk',
      description: 'Have 10 or more policies active simultaneously.',
      condition: 'activePolicies >= 10',
    ),
    Achievement(
      id: 'speed_run',
      title: 'Speed Runner',
      description: 'Get a game over within the first 6 months.',
      condition: 'isGameOver && currentMonth <= 6',
    ),
  ];

  static Achievement? getAchievementById(String id) {
    try {
      return allAchievements.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }
}

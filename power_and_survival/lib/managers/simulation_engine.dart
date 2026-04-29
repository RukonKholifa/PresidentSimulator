import '../models/game_state.dart';
import '../models/country_stats.dart';
import '../models/event_model.dart';
import '../models/neighbor_country.dart';
import '../config/game_balance.dart';
import '../data/country_traits_data.dart';
import 'stats_manager.dart';
import 'event_manager.dart';
import 'budget_manager.dart';
import 'policy_manager.dart';
import 'character_manager.dart';
import 'risk_calculator.dart';
import 'news_generator.dart';
import 'faction_manager.dart';
import 'achievement_manager.dart';
import 'election_manager.dart';

class SimulationEngine {
  final StatsManager statsManager = StatsManager();
  final EventManager eventManager = EventManager();
  final BudgetManager budgetManager = BudgetManager();
  final PolicyManager policyManager = PolicyManager();
  final CharacterManager characterManager = CharacterManager();
  final RiskCalculator riskCalculator = RiskCalculator();
  final NewsGenerator newsGenerator = NewsGenerator();
  final FactionManager factionManager = FactionManager();
  final AchievementManager achievementManager = AchievementManager();
  final ElectionManager electionManager = ElectionManager();

  GameState createNewGame({
    required String presidentName,
    required String countryName,
    required String partyName,
    required String ideology,
    required String difficulty,
    required String countryTrait,
  }) {
    final startingStats = GameBalance.startingStats[difficulty] ?? GameBalance.startingStats['normal']!;

    final state = GameState(
      presidentName: presidentName,
      countryName: countryName,
      partyName: partyName,
      ideology: ideology,
      difficulty: difficulty,
      countryTrait: countryTrait,
      stats: _createStatsFromMap(startingStats, countryTrait),
      characters: characterManager.generateStartingCharacters(),
      neighbors: _createNeighborCountries(),
    );

    state.newsHistory.addAll(newsGenerator.generateMonthlyNews(state));
    state.riskScores = riskCalculator.calculateRisks(state);

    return state;
  }

  CountryStats _createStatsFromMap(Map<String, double> baseStats, String trait) {
    final modifiers = CountryTraitsData.getStatModifiers(trait);
    final modified = Map<String, double>.from(baseStats);

    for (final entry in modifiers.entries) {
      if (modified.containsKey(entry.key)) {
        modified[entry.key] = modified[entry.key]! + entry.value;
      }
    }

    return CountryStats.fromMap(modified);
  }

  List<NeighborCountry> _createNeighborCountries() {
    return [
      NeighborCountry(
        id: 'north', name: 'Nordland', governmentType: 'Democracy',
        relationScore: 60, militaryStrength: 'high', economicStrength: 'high',
      ),
      NeighborCountry(
        id: 'east', name: 'Eastmark', governmentType: 'Authoritarian',
        relationScore: 40, militaryStrength: 'medium', economicStrength: 'medium',
      ),
      NeighborCountry(
        id: 'south', name: 'Southvale', governmentType: 'Democracy',
        relationScore: 55, militaryStrength: 'low', economicStrength: 'low',
      ),
      NeighborCountry(
        id: 'west', name: 'Westreach', governmentType: 'Monarchy',
        relationScore: 50, militaryStrength: 'medium', economicStrength: 'high',
      ),
    ];
  }

  void advanceMonth(GameState state) {
    state.currentMonth++;

    budgetManager.processBudget(state);
    policyManager.applyMonthlyPolicyEffects(state);
    statsManager.applyMonthlyDecay(state);
    statsManager.applyDynamicRelationships(state);
    statsManager.applyBudgetEffects(state);
    characterManager.updateCharacterMonthly(state);
    factionManager.updateFactionSupport(state);

    _checkPromises(state);

    state.riskScores = riskCalculator.calculateRisks(state);

    state.newsHistory.addAll(newsGenerator.generateMonthlyNews(state));
    if (state.newsHistory.length > 50) {
      state.newsHistory = state.newsHistory.sublist(state.newsHistory.length - 50);
    }

    achievementManager.checkAchievements(state);

    _checkGameOver(state);
  }

  EventModel? getMonthlyEvent(GameState state) {
    if (eventManager.shouldTriggerEvent(state)) {
      return eventManager.getRandomEvent(state);
    }
    return null;
  }

  void applyEventChoice(GameState state, EventModel event, EventChoice choice) {
    eventManager.applyChoice(state, event, choice);
    state.riskScores = riskCalculator.calculateRisks(state);
  }

  void _checkPromises(GameState state) {
    for (final promise in state.activePromises) {
      if (promise.isKept || promise.isBroken) continue;

      if (state.currentMonth >= promise.deadlineMonth) {
        promise.isBroken = true;
        for (final entry in promise.brokenEffects.entries) {
          state.stats.applyStat(entry.key, entry.value);
        }
        state.diaryEntries.add(
          'Month ${state.currentMonth}: Broken promise — ${promise.text}',
        );
      }
    }
  }

  void _checkGameOver(GameState state) {
    if (state.stats.treasury < GameBalance.bankruptcyLimit) {
      state.isGameOver = true;
      state.gameOverReason = 'bankruptcy';
      return;
    }

    if (state.stats.stability <= GameBalance.collapseStability) {
      state.isGameOver = true;
      state.gameOverReason = 'stability_collapse';
      return;
    }

    if (state.stats.happiness <= GameBalance.collapseHappiness) {
      state.isGameOver = true;
      state.gameOverReason = 'revolution';
      return;
    }

    if (state.stats.corruption >= GameBalance.maxCorruption) {
      state.isGameOver = true;
      state.gameOverReason = 'corruption';
      return;
    }

    if (state.riskScores.coup >= GameBalance.coupRiskThreshold) {
      state.isGameOver = true;
      state.gameOverReason = 'coup';
      return;
    }

    if (state.riskScores.revolution >= GameBalance.revolutionRiskThreshold) {
      state.isGameOver = true;
      state.gameOverReason = 'revolution';
      return;
    }

    if (state.riskScores.impeachment >= GameBalance.impeachmentRiskThreshold) {
      state.isGameOver = true;
      state.gameOverReason = 'impeachment';
      return;
    }
  }

  String? determineLegacyEnding(GameState state) {
    if (state.isGameOver) {
      switch (state.gameOverReason) {
        case 'revolution':
        case 'coup':
          return 'fallen_dictator';
        case 'bankruptcy':
          return 'bankrupt_nation';
        case 'impeachment':
          return 'scandal_exit';
        default:
          return 'fallen_dictator';
      }
    }

    if (state.stats.approvalRating >= 80 &&
        state.stats.happiness >= 75 &&
        state.stats.economy >= 60) {
      return 'beloved_leader';
    }

    if (state.stats.military >= 75 &&
        state.stats.stability >= 70 &&
        state.stats.happiness < 40) {
      return 'iron_ruler';
    }

    if (state.stats.economy >= 80 &&
        state.stats.treasury >= 500 &&
        state.stats.debt <= 100) {
      return 'economic_architect';
    }

    return 'peaceful_transition';
  }
}

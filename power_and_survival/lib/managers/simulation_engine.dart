import 'dart:math';

import '../models/game_state.dart';
import '../models/country_stats.dart';
import '../models/event_model.dart';
import '../models/neighbor_country.dart';
import '../config/game_balance.dart';
import '../data/country_traits_data.dart';
import '../data/policies_data.dart';
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

class MonthlyResult {
  final GameState state;
  final List<String> news;
  final String diary;

  MonthlyResult({required this.state, required this.news, required this.diary});
}

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

  final Random _random = Random();

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

  // ================================================================
  // MAIN MONTHLY LOOP — runs in exact order per spec
  // ================================================================

  MonthlyResult runMonth(GameState state) {
    applyPolicyEffects(state);
    applyBudgetEffects(state);
    applyCitizenGroupReactions(state);
    applyCharacterBehaviors(state);
    calculateIncome(state);
    applyDebtInterest(state);
    applyDynamicStatRelationships(state);
    checkCrisisChainTriggers(state);
    recalculateRiskScores(state);
    checkGameOverConditions(state);
    checkPromiseDeadlines(state);
    checkMinisterEmbezzlement(state);
    final news = generateMonthlyNews(state);
    final diary = generateDiaryEntry(state);
    _advanceMonthCounter(state);
    return MonthlyResult(state: state, news: news, diary: diary);
  }

  void advanceMonth(GameState state) {
    final result = runMonth(state);
    state.newsHistory.addAll(result.news);
    if (state.newsHistory.length > 50) {
      state.newsHistory = state.newsHistory.sublist(state.newsHistory.length - 50);
    }
    state.diaryEntries.add(result.diary);
    achievementManager.checkAchievements(state);
  }

  void _advanceMonthCounter(GameState state) {
    state.currentMonth++;
  }

  // ================================================================
  // 1. applyPolicyEffects
  // ================================================================

  void applyPolicyEffects(GameState state) {
    for (final policyId in state.activePolicyIds) {
      final policy = PoliciesData.getPolicyById(policyId);
      if (policy == null) continue;

      for (final entry in policy.monthlyEffects.entries) {
        state.stats.applyStat(entry.key, entry.value);
      }

      for (final entry in policy.sideEffects.entries) {
        state.stats.applyStat(entry.key, entry.value);
      }

      state.stats.treasury -= policy.monthlyCost;
    }
    state.stats.clamp();
  }

  // ================================================================
  // 2. applyBudgetEffects
  // ================================================================

  void applyBudgetEffects(GameState state) {
    final budget = state.budgetAllocation;
    final income = GameBalance.baseIncome[state.difficulty] ?? 350;

    final healthAlloc = budget['health'] ?? 0;
    final educationAlloc = budget['education'] ?? 0;
    final militaryAlloc = budget['military'] ?? 0;
    final securityAlloc = budget['security'] ?? 0;
    final infrastructureAlloc = budget['infrastructure'] ?? 0;
    final welfareAlloc = budget['welfare'] ?? 0;

    final healthSpend = healthAlloc * income;
    final educationSpend = educationAlloc * income;
    final militarySpend = militaryAlloc * income;
    final securitySpend = securityAlloc * income;
    final infraSpend = infrastructureAlloc * income;
    final welfareSpend = welfareAlloc * income;

    if (healthSpend > 20) state.stats.health += healthSpend * 0.015;
    if (educationSpend > 20) state.stats.education += educationSpend * 0.012;
    if (militarySpend > 20) state.stats.military += militarySpend * 0.01;
    if (securitySpend > 20) state.stats.crime -= securitySpend * 0.01;
    if (infraSpend > 15) {
      state.stats.economy += infraSpend * 0.008;
      state.stats.stability += infraSpend * 0.005;
    }
    if (welfareSpend > 15) {
      state.citizenGroups.farmers += welfareSpend * 0.005;
    }

    // Media budget → Media Trust
    final mediaAlloc = budget['reserve'] ?? 0;
    if (mediaAlloc > 0.05) state.stats.mediaTrust += mediaAlloc * income * 0.003;

    // Decay if underfunded
    if (healthAlloc < 0.1) state.stats.health += GameBalance.healthDecayNoFunding;
    if (educationAlloc < 0.1) state.stats.education += GameBalance.educationDecayNoFunding;
    if (militaryAlloc < 0.1) state.stats.military += GameBalance.militaryDecayNoFunding;
    if (infrastructureAlloc < 0.1) state.stats.economy += GameBalance.infrastructureDecayNoFunding;

    state.stats.clamp();
    state.citizenGroups.clamp();
  }

  // ================================================================
  // 3. applyCitizenGroupReactions
  // ================================================================

  void applyCitizenGroupReactions(GameState state) {
    final stats = state.stats;
    final groups = state.citizenGroups;

    // Students: education, economy (job proxy), freedom (inverse of corruption)
    final studentTarget = (stats.education * 0.4 + stats.economy * 0.3 + (100 - stats.corruption) * 0.3);
    groups.students += (studentTarget - groups.students) * 0.1;

    // Workers: economy, income stability
    final workerTarget = (stats.economy * 0.5 + stats.happiness * 0.3 + stats.stability * 0.2);
    groups.workers += (workerTarget - groups.workers) * 0.1;

    // Farmers: welfare budget, food-related stability
    final farmerBudget = state.budgetAllocation['welfare'] ?? 0;
    final farmerTarget = (farmerBudget * 100 * 0.4 + stats.economy * 0.3 + stats.stability * 0.3);
    groups.farmers += (farmerTarget - groups.farmers) * 0.1;

    // Business: economy, tax policy (stability proxy), stability
    final businessTarget = (stats.economy * 0.5 + stats.stability * 0.3 + (100 - stats.corruption) * 0.2);
    groups.businessOwners += (businessTarget - groups.businessOwners) * 0.1;

    // Military: military budget, army chief loyalty
    final armyChief = state.characters.where((c) => c.role == 'army_chief' && c.isActive).toList();
    final chiefLoyalty = armyChief.isNotEmpty ? armyChief.first.loyalty : 50.0;
    final militaryTarget = (stats.military * 0.4 + chiefLoyalty * 0.3 + (state.budgetAllocation['military'] ?? 0) * 100 * 0.3);
    groups.military += (militaryTarget - groups.military) * 0.1;

    // Religious: cultural policies (stability proxy), freedom
    final religiousTarget = (stats.stability * 0.4 + (100 - stats.corruption) * 0.3 + stats.happiness * 0.3);
    groups.religiousCommunity += (religiousTarget - groups.religiousCommunity) * 0.1;

    // Media
    final mediaTarget = (stats.mediaTrust * 0.6 + (100 - stats.corruption) * 0.4);
    groups.media += (mediaTarget - groups.media) * 0.1;

    // Foreign allies
    final foreignTarget = (stats.internationalRelations * 0.7 + stats.economy * 0.3);
    groups.foreignAllies += (foreignTarget - groups.foreignAllies) * 0.1;

    // Opposition base: grows when approval is low
    final oppTarget = (100 - stats.approvalRating) * 0.5 + stats.oppositionPower * 0.5;
    groups.oppositionBase += (oppTarget - groups.oppositionBase) * 0.1;

    groups.clamp();
  }

  // ================================================================
  // 4. applyCharacterBehaviors
  // ================================================================

  void applyCharacterBehaviors(GameState state) {
    for (final character in state.characters) {
      if (!character.isActive) continue;

      if (character.loyalty < 40 && character.ambition > 60) {
        final roll = _random.nextDouble() * 100;

        if (roll < 30) {
          // Leak to media → scandal risk +5
          state.stats.mediaTrust -= 2;
          state.stats.corruption += 0.5;
          state.diaryEntries.add(
            'Month ${state.currentMonth}: ${character.name} leaked information to the press.',
          );
        } else if (roll < 50) {
          // Demand policy change → queue character event
          if (character.currentDemands.isEmpty) {
            character.currentDemands.add('Demands policy changes');
          }
        } else if (roll < 65) {
          // Form alliance → faction power changes
          final factionChars = state.characters.where(
            (c) => c.factionId == character.factionId && c.id != character.id && c.isActive,
          );
          for (final ally in factionChars) {
            ally.ambition += 2;
            ally.loyalty -= 1;
          }
        } else if (roll < 75) {
          // Embezzle (if corruption > 50)
          if (character.corruption > 50) {
            final amount = 10.0 + _random.nextInt(41);
            state.stats.treasury -= amount;
            state.stats.corruption += 0.5;
          }
        }
        // else: 25% nothing
      } else if (character.loyalty > 70) {
        if (_random.nextDouble() < 0.05) {
          state.diaryEntries.add(
            'Month ${state.currentMonth}: ${character.name} provided a helpful intelligence warning.',
          );
          state.stats.stability += 1;
        }
      }

      // Track disloyalty
      if (character.loyalty < 45) {
        character.monthsDisloyal++;
      } else {
        character.monthsDisloyal = 0;
      }

      // Hidden trait effects
      switch (character.hiddenTrait) {
        case 'loyalist':
          character.loyalty = (character.loyalty + 0.5).clamp(0, 100);
        case 'traitor':
          character.loyalty = (character.loyalty - 0.5).clamp(0, 100);
        case 'opportunist':
          if (state.stats.approvalRating > 60) {
            character.loyalty = (character.loyalty + 0.3).clamp(0, 100);
          } else {
            character.loyalty = (character.loyalty - 0.3).clamp(0, 100);
          }
        case 'reformist':
          if (state.stats.corruption > 50) {
            character.loyalty = (character.loyalty - 0.3).clamp(0, 100);
          }
      }
    }
  }

  // ================================================================
  // 5. calculateIncome
  // ================================================================

  void calculateIncome(GameState state) {
    final base = GameBalance.baseIncome[state.difficulty] ?? 350;
    final economyFactor = state.stats.economy / 100;
    final stabilityFactor = state.stats.stability / 100;
    final corruptionDrain = 1 - state.stats.corruption / 200;
    final businessFactor = state.citizenGroups.businessOwners / 100 * 0.3 + 0.7;

    double income = base * economyFactor * stabilityFactor * corruptionDrain * businessFactor;

    // Deduct all active policy costs
    double policyCost = 0;
    for (final policyId in state.activePolicyIds) {
      final policy = PoliciesData.getPolicyById(policyId);
      if (policy != null) policyCost += policy.monthlyCost;
    }
    income -= policyCost;

    // Debt interest is handled separately in applyDebtInterest

    state.stats.treasury += income;
  }

  // ================================================================
  // 6. applyDebtInterest
  // ================================================================

  void applyDebtInterest(GameState state) {
    if (state.stats.debt <= 0) return;

    double interestRate;
    if (state.stats.debt > 1000) {
      interestRate = GameBalance.debtInterestCritical;
    } else if (state.stats.debt > 500) {
      interestRate = GameBalance.debtInterestHigh;
    } else {
      interestRate = GameBalance.debtInterestNormal;
    }

    final interest = state.stats.debt * interestRate;
    state.stats.treasury -= interest;

    if (state.stats.treasury < 0) {
      state.stats.debt += state.stats.treasury.abs();
      state.stats.treasury = 0;
    }

    // Debt payment from budget allocation
    final debtAlloc = state.budgetAllocation['debtPayment'] ?? 0;
    if (debtAlloc > 0 && state.stats.debt > 0) {
      final baseIncome = GameBalance.baseIncome[state.difficulty] ?? 350;
      final payment = baseIncome * debtAlloc;
      state.stats.debt -= payment;
      state.stats.treasury -= payment;
      if (state.stats.debt < 0) state.stats.debt = 0;
      if (state.stats.treasury < 0) {
        state.stats.debt += state.stats.treasury.abs();
        state.stats.treasury = 0;
      }
    }
  }

  // ================================================================
  // 7. applyDynamicStatRelationships
  // ================================================================

  void applyDynamicStatRelationships(GameState state) {
    final stats = state.stats;

    if (stats.economy > 65) {
      stats.happiness += 1.0;
      stats.stability += 0.5;
    }
    if (stats.debt > 500) {
      stats.economy -= 1.0;
      stats.mediaTrust -= 0.5;
    }
    if (stats.corruption > 60) {
      stats.economy -= 1.0;
      stats.happiness -= 1.0;
      stats.mediaTrust -= 1.0;
      stats.internationalRelations -= 1.0;
    }
    if (stats.education < 35 && state.currentMonth > 6) {
      stats.economy -= 0.5;
    }
    if (stats.health < 35) {
      stats.happiness -= 1.0;
      stats.stability -= 0.5;
    }
    if (stats.crime > 65) {
      stats.happiness -= 1.0;
      stats.stability -= 1.0;
    }

    stats.clamp();
  }

  // ================================================================
  // 8. checkCrisisChainTriggers
  // ================================================================

  void checkCrisisChainTriggers(GameState state) {
    // Protest chain
    if (state.stats.happiness < GameBalance.protestTriggerHappiness &&
        !state.activeCrisisChains.contains('protest_chain')) {
      state.activeCrisisChains.add('protest_chain');
    }
    // Escalate protest chain stages
    if (state.activeCrisisChains.contains('protest_chain')) {
      if (state.stats.happiness < GameBalance.riotTriggerHappiness) {
        // Already in chain, escalation handled by event_manager chain progression
      }
    }

    // Scandal chain
    if (state.stats.corruption > GameBalance.scandalTriggerCorruption &&
        !state.activeCrisisChains.contains('scandal_chain')) {
      state.activeCrisisChains.add('scandal_chain');
    }

    // IMF chain
    if (state.stats.debt > GameBalance.imfTriggerDebt &&
        !state.activeCrisisChains.contains('imf_chain')) {
      state.activeCrisisChains.add('imf_chain');
    }

    // Coup warning chain
    final armyChief = state.characters.where((c) => c.role == 'army_chief' && c.isActive).toList();
    if (armyChief.isNotEmpty && armyChief.first.loyalty < GameBalance.coupWarningArmyLoyalty &&
        !state.activeCrisisChains.contains('coup_chain')) {
      state.activeCrisisChains.add('coup_chain');
    }

    // Student movement chain
    if (state.stats.education < GameBalance.studentMovementEducation &&
        !state.activeCrisisChains.contains('student_chain')) {
      state.activeCrisisChains.add('student_chain');
    }

    // Police crisis chain
    if (state.stats.crime > GameBalance.policeCrisisCrime &&
        !state.activeCrisisChains.contains('police_chain')) {
      state.activeCrisisChains.add('police_chain');
    }
  }

  // ================================================================
  // 9. checkGameOverConditions
  // ================================================================

  void checkGameOverConditions(GameState state) {
    if (state.isGameOver) return;

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

    // Opposition too powerful
    if (state.stats.oppositionPower >= GameBalance.maxOpposition) {
      state.isGameOver = true;
      state.gameOverReason = 'opposition';
      return;
    }

    // Characters with monthsDisloyal > 3 can trigger crisis
    for (final character in state.characters) {
      if (character.isActive && character.monthsDisloyal > 3) {
        if (character.role == 'army_chief' && character.ambition > 70) {
          state.isGameOver = true;
          state.gameOverReason = 'coup';
          return;
        }
      }
    }
  }

  // ================================================================
  // 10. recalculateRiskScores
  // ================================================================

  void recalculateRiskScores(GameState state) {
    state.riskScores = riskCalculator.calculateRisks(state);
  }

  // ================================================================
  // 11. checkPromiseDeadlines
  // ================================================================

  void checkPromiseDeadlines(GameState state) {
    for (final promise in state.activePromises) {
      if (promise.isKept || promise.isBroken) continue;

      if (state.currentMonth >= promise.deadlineMonth) {
        // Check if promise condition is met based on keptEffects keys
        bool conditionMet = false;
        for (final entry in promise.keptEffects.entries) {
          if (state.stats.getStat(entry.key) >= 50) {
            conditionMet = true;
            break;
          }
        }

        if (conditionMet) {
          promise.isKept = true;
          for (final entry in promise.keptEffects.entries) {
            state.stats.applyStat(entry.key, entry.value);
          }
          state.diaryEntries.add(
            'Month ${state.currentMonth}: Kept promise — ${promise.text}',
          );
        } else {
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
  }

  // ================================================================
  // 12. checkMinisterEmbezzlement
  // ================================================================

  void checkMinisterEmbezzlement(GameState state) {
    for (final character in state.characters) {
      if (!character.isActive) continue;
      if (character.corruption <= 65) continue;

      final chance = (character.corruption - 65) / 35 * 0.15;
      if (_random.nextDouble() < chance) {
        final amount = 10.0 + _random.nextInt(41);
        state.stats.treasury -= amount;
        state.stats.corruption += 0.5;

        // Check if intelligence chief can detect it
        final intelChief = state.characters.where(
          (c) => c.role == 'intelligence_chief' && c.isActive,
        ).toList();

        if (intelChief.isNotEmpty && intelChief.first.loyalty > 60) {
          final intelBudget = (state.budgetAllocation['security'] ?? 0) * 100;
          if (intelBudget > 50) {
            state.diaryEntries.add(
              'Month ${state.currentMonth}: Intelligence discovered ${character.name} embezzling funds!',
            );
          }
        }
      }
    }
  }

  // ================================================================
  // 13. generateMonthlyNews
  // ================================================================

  List<String> generateMonthlyNews(GameState state) {
    final headlines = <String>[];
    final stats = state.stats;

    // Economy headline
    if (stats.economy > 70) {
      headlines.add('Economic growth continues as GDP rises for another quarter');
    } else if (stats.economy < 30) {
      headlines.add('Economic crisis deepens as businesses close nationwide');
    } else {
      headlines.add('Economy holds steady amid global uncertainty');
    }

    // Approval headline
    if (stats.approvalRating > 70) {
      headlines.add('President ${state.presidentName} enjoys strong public support');
    } else if (stats.approvalRating < 30) {
      headlines.add('Public frustration mounts as presidential approval hits new low');
    }

    // Corruption headline
    if (stats.corruption > 60) {
      headlines.add('Corruption allegations continue to plague the government');
    }

    // Health headline
    if (stats.health < 35) {
      headlines.add('Hospitals overwhelmed as healthcare system struggles');
    } else if (stats.health > 75) {
      headlines.add('National health indicators show significant improvement');
    }

    // Security headline
    if (stats.crime > 60) {
      headlines.add('Crime wave: citizens demand stronger police response');
    } else if (stats.crime < 20) {
      headlines.add('Crime at record lows thanks to effective law enforcement');
    }

    // International headline
    if (stats.internationalRelations > 70) {
      headlines.add('${state.countryName} strengthens ties with international community');
    } else if (stats.internationalRelations < 30) {
      headlines.add('Diplomatic isolation grows as allies distance themselves');
    }

    // Debt headline
    if (stats.debt > 700) {
      headlines.add('National debt reaches alarming levels, economists warn');
    }

    // Ensure at least 3 headlines
    if (headlines.length < 3) {
      headlines.add('${state.countryName} enters month ${state.currentMonth} of current administration');
    }
    if (headlines.length < 3) {
      headlines.add('Parliament debates next steps for national policy');
    }
    if (headlines.length < 3) {
      headlines.add('Citizens wait to see results of recent government decisions');
    }

    return headlines.take(5).toList();
  }

  // ================================================================
  // 14. generateDiaryEntry
  // ================================================================

  String generateDiaryEntry(GameState state) {
    final stats = state.stats;
    final month = state.currentMonth;

    if (stats.stability < 30) {
      final templates = [
        'Month $month: I can feel the ground shifting beneath me. The streets are restless, the generals are whispering, and even my closest allies look at me with doubt.',
        'Month $month: Another sleepless night. The reports on my desk paint a grim picture — instability everywhere. I wonder how much longer I can hold this together.',
        'Month $month: Paranoia is not irrational when they really are out to get you. I trust no one anymore. Every meeting feels like a potential trap.',
      ];
      return templates[_random.nextInt(templates.length)];
    }

    if (state.riskScores.coup > 60) {
      final templates = [
        'Month $month: The army chief was unusually quiet in today\'s briefing. I don\'t like quiet generals. They\'re either planning something or they\'ve already decided.',
        'Month $month: I\'ve increased my personal security detail. The intelligence reports are troubling — whispers of military discontent grow louder each week.',
        'Month $month: I caught the defense minister making private calls again. When I asked who, he claimed it was his wife. I don\'t believe him.',
      ];
      return templates[_random.nextInt(templates.length)];
    }

    if (stats.happiness > 65 && stats.economy > 60) {
      final templates = [
        'Month $month: For once, the news is good. The economy is growing, people are smiling, and even the opposition has gone quiet. Perhaps I\'m doing something right.',
        'Month $month: Walked through the market district today without bodyguards. People waved, children cheered. This is why I entered politics.',
        'Month $month: The cabinet meeting was almost pleasant today. Numbers are up, complaints are down. I allow myself a moment of cautious optimism.',
      ];
      return templates[_random.nextInt(templates.length)];
    }

    if (stats.corruption > 60) {
      final templates = [
        'Month $month: I know the corruption runs deep. I can see it in the way contracts are awarded, in the unexplained wealth of certain officials. But cleaning house risks losing allies I cannot afford to lose.',
        'Month $month: Another scandal in the papers. The journalists are circling like vultures. I need to do something about corruption before it devours everything.',
      ];
      return templates[_random.nextInt(templates.length)];
    }

    if (stats.debt > 500) {
      final templates = [
        'Month $month: The debt keeps climbing. Every month we borrow more to pay for what we borrowed last month. The finance minister says we have options, but his voice lacks conviction.',
        'Month $month: International creditors called again today. Their patience is not infinite. We need a plan before they decide our economy is no longer worth propping up.',
      ];
      return templates[_random.nextInt(templates.length)];
    }

    // Default neutral entries
    final templates = [
      'Month $month: Another month passes. The work of governing is endless — an ocean of documents, meetings, and decisions. I do my best to steer the ship.',
      'Month $month: Reviewed the monthly reports today. Some things improving, others declining. The balance of power is fragile, but I remain focused.',
      'Month $month: Met with advisors to discuss the path forward. No easy answers, but I\'m determined to leave this country better than I found it.',
    ];
    return templates[_random.nextInt(templates.length)];
  }

  // ================================================================
  // EVENT HANDLING (public API for screens)
  // ================================================================

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

  // ================================================================
  // LEGACY ENDING
  // ================================================================

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
        case 'opposition':
          return 'fallen_dictator';
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

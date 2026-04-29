import '../models/game_state.dart';
import '../config/game_balance.dart';

class StatsManager {
  void applyStatEffects(GameState state, Map<String, double> effects) {
    for (final entry in effects.entries) {
      state.stats.applyStat(entry.key, entry.value);
    }
  }

  void applyMonthlyDecay(GameState state) {
    final budget = state.budgetAllocation;

    if ((budget['health'] ?? 0) < 0.1) {
      state.stats.health += GameBalance.healthDecayNoFunding;
    }
    if ((budget['education'] ?? 0) < 0.1) {
      state.stats.education += GameBalance.educationDecayNoFunding;
    }
    if ((budget['military'] ?? 0) < 0.1) {
      state.stats.military += GameBalance.militaryDecayNoFunding;
    }
    if ((budget['infrastructure'] ?? 0) < 0.1) {
      state.stats.economy += GameBalance.infrastructureDecayNoFunding;
    }

    state.stats.clamp();
  }

  void applyDynamicRelationships(GameState state) {
    final stats = state.stats;

    if (stats.economy > 65) {
      stats.happiness += GameBalance.economyToHappinessRate * 0.1;
    }
    if (stats.corruption > 50) {
      stats.economy += GameBalance.corruptionToEconomyRate * 0.1;
      stats.happiness += GameBalance.corruptionToHappinessRate * 0.1;
    }
    if (stats.crime > 50) {
      stats.happiness += GameBalance.crimeToHappinessRate * 0.1;
    }
    if (stats.health < 30) {
      stats.happiness += GameBalance.lowHealthToHappinessRate * 0.1;
    }
    if (stats.debt > 500) {
      stats.economy += GameBalance.highDebtToEconomyRate * 0.1;
    }

    stats.clamp();
  }

  void applyBudgetEffects(GameState state) {
    final budget = state.budgetAllocation;
    final income = GameBalance.baseIncome[state.difficulty] ?? 350;
    final totalSpending = income;

    final healthSpend = (budget['health'] ?? 0) * totalSpending;
    final educationSpend = (budget['education'] ?? 0) * totalSpending;
    final militarySpend = (budget['military'] ?? 0) * totalSpending;
    final welfareSpend = (budget['welfare'] ?? 0) * totalSpending;
    final securitySpend = (budget['security'] ?? 0) * totalSpending;
    final debtPayment = (budget['debtPayment'] ?? 0) * totalSpending;

    if (healthSpend > 40) state.stats.health += 0.5;
    if (educationSpend > 40) state.stats.education += 0.5;
    if (militarySpend > 50) state.stats.military += 0.5;
    if (welfareSpend > 30) state.stats.happiness += 0.3;
    if (securitySpend > 30) state.stats.crime -= 0.3;
    if (debtPayment > 30 && state.stats.debt > 0) {
      state.stats.debt -= debtPayment * 0.5;
    }

    state.stats.clamp();
  }

  void processMonthlyIncome(GameState state) {
    final income = GameBalance.baseIncome[state.difficulty] ?? 350;
    final economyBonus = state.stats.economy * 0.02;
    final totalIncome = income + economyBonus;

    double totalPolicyCost = 0;
    state.stats.treasury += totalIncome - totalPolicyCost;

    double interestRate;
    if (state.stats.debt > 1000) {
      interestRate = GameBalance.debtInterestCritical;
    } else if (state.stats.debt > 500) {
      interestRate = GameBalance.debtInterestHigh;
    } else {
      interestRate = GameBalance.debtInterestNormal;
    }

    if (state.stats.debt > 0) {
      state.stats.debt += state.stats.debt * interestRate;
    }
  }

  Map<String, double> getStatSummary(GameState state) {
    return {
      'economy': state.stats.economy,
      'happiness': state.stats.happiness,
      'military': state.stats.military,
      'corruption': state.stats.corruption,
      'health': state.stats.health,
      'education': state.stats.education,
      'crime': state.stats.crime,
      'internationalRelations': state.stats.internationalRelations,
      'stability': state.stats.stability,
      'mediaTrust': state.stats.mediaTrust,
      'oppositionPower': state.stats.oppositionPower,
      'approvalRating': state.stats.approvalRating,
    };
  }
}

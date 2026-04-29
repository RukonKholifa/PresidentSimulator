import '../models/game_state.dart';
import '../config/game_balance.dart';

class BudgetManager {
  static const Map<String, String> budgetCategories = {
    'health': 'Health',
    'education': 'Education',
    'military': 'Military',
    'infrastructure': 'Infrastructure',
    'welfare': 'Welfare',
    'security': 'Security',
    'debtPayment': 'Debt Payment',
    'reserve': 'Reserve',
  };

  double getMonthlyIncome(GameState state) {
    final base = GameBalance.baseIncome[state.difficulty] ?? 350;
    final economyBonus = state.stats.economy * 0.5;
    return base + economyBonus;
  }

  double getMonthlyExpenses(GameState state) {
    double policyCost = 0;
    return policyCost;
  }

  double getNetIncome(GameState state) {
    return getMonthlyIncome(state) - getMonthlyExpenses(state);
  }

  void processBudget(GameState state) {
    final income = getMonthlyIncome(state);
    final expenses = getMonthlyExpenses(state);
    final net = income - expenses;

    state.stats.treasury += net;

    if (state.stats.debt > 0) {
      double interestRate;
      if (state.stats.debt > 1000) {
        interestRate = GameBalance.debtInterestCritical;
      } else if (state.stats.debt > 500) {
        interestRate = GameBalance.debtInterestHigh;
      } else {
        interestRate = GameBalance.debtInterestNormal;
      }
      state.stats.debt += state.stats.debt * interestRate;
    }

    final debtAllocation = state.budgetAllocation['debtPayment'] ?? 0;
    if (debtAllocation > 0 && state.stats.debt > 0) {
      final payment = income * debtAllocation;
      state.stats.debt -= payment;
      state.stats.treasury -= payment;
      if (state.stats.debt < 0) state.stats.debt = 0;
    }
  }

  bool validateAllocation(Map<String, double> allocation) {
    double total = 0;
    for (final value in allocation.values) {
      if (value < 0 || value > 1) return false;
      total += value;
    }
    return (total - 1.0).abs() < 0.01;
  }

  Map<String, double> normalizeBudget(Map<String, double> allocation) {
    double total = allocation.values.fold(0.0, (sum, v) => sum + v);
    if (total == 0) return Map.from(allocation);
    return allocation.map((k, v) => MapEntry(k, v / total));
  }
}

import '../models/game_state.dart';
import '../models/risk_scores.dart';
import '../config/game_balance.dart';

class RiskCalculator {
  RiskScores calculateRisks(GameState state) {
    return RiskScores(
      coup: _calculateCoupRisk(state),
      revolution: _calculateRevolutionRisk(state),
      bankruptcy: _calculateBankruptcyRisk(state),
      scandal: _calculateScandalRisk(state),
      impeachment: _calculateImpeachmentRisk(state),
      electionLoss: _calculateElectionLossRisk(state),
    );
  }

  double _calculateCoupRisk(GameState state) {
    double risk = 0;

    risk += (100 - state.stats.military) * GameBalance.coupWeightMilitary;
    risk += (100 - state.stats.stability) * GameBalance.coupWeightStability;
    risk += (100 - state.stats.approvalRating) * GameBalance.coupWeightApproval;

    final armyChief = state.characters.where((c) => c.role == 'army_chief' && c.isActive).toList();
    if (armyChief.isNotEmpty) {
      risk += (100 - armyChief.first.loyalty) * GameBalance.coupWeightLoyalty;
      risk += armyChief.first.ambition * GameBalance.coupWeightAmbition;
    }

    return risk.clamp(0, 100);
  }

  double _calculateRevolutionRisk(GameState state) {
    double risk = 0;

    if (state.stats.happiness < GameBalance.protestTriggerHappiness) {
      risk += (GameBalance.protestTriggerHappiness - state.stats.happiness) * 2;
    }
    if (state.stats.happiness < GameBalance.revolutionTriggerHappiness) {
      risk += 30;
    }

    risk += state.stats.oppositionPower * 0.3;
    risk += (100 - state.stats.stability) * 0.3;
    risk += state.stats.corruption * 0.2;

    return risk.clamp(0, 100);
  }

  double _calculateBankruptcyRisk(GameState state) {
    double risk = 0;

    if (state.stats.treasury < 100) {
      risk += (100 - state.stats.treasury) * 0.5;
    }
    if (state.stats.debt > 500) {
      risk += (state.stats.debt - 500) * 0.1;
    }
    if (state.stats.economy < 30) {
      risk += (30 - state.stats.economy) * 1.5;
    }

    return risk.clamp(0, 100);
  }

  double _calculateScandalRisk(GameState state) {
    double risk = 0;

    if (state.stats.corruption > GameBalance.scandalTriggerCorruption) {
      risk += (state.stats.corruption - GameBalance.scandalTriggerCorruption) * 2;
    }
    risk += state.stats.corruption * 0.3;
    risk += (100 - state.stats.mediaTrust) * 0.2;

    return risk.clamp(0, 100);
  }

  double _calculateImpeachmentRisk(GameState state) {
    double risk = 0;

    risk += state.stats.oppositionPower * 0.4;
    risk += state.stats.corruption * 0.3;
    risk += (100 - state.stats.approvalRating) * 0.2;
    risk += (100 - state.stats.mediaTrust) * 0.1;

    return risk.clamp(0, 100);
  }

  double _calculateElectionLossRisk(GameState state) {
    double score = 0;

    score += state.stats.approvalRating * GameBalance.electionWeightApproval;
    score += state.stats.happiness * GameBalance.electionWeightHappiness;
    score += state.stats.economy * GameBalance.electionWeightEconomy;
    score += (100 - state.stats.corruption) * GameBalance.electionWeightCorruption;
    score += state.stats.stability * GameBalance.electionWeightStability;
    score += (100 - state.stats.oppositionPower) * GameBalance.electionWeightOpposition;
    score += state.stats.mediaTrust * GameBalance.electionWeightMedia;

    return (100 - score).clamp(0, 100);
  }
}

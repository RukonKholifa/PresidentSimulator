import 'dart:math';
import '../models/game_state.dart';
import '../config/game_balance.dart';

class ElectionResult {
  final double playerScore;
  final double opponentScore;
  final bool playerWins;
  final String narrative;

  ElectionResult({
    required this.playerScore,
    required this.opponentScore,
    required this.playerWins,
    required this.narrative,
  });
}

class ElectionManager {
  final Random _random = Random();

  bool isElectionTime(GameState state) {
    return state.currentMonth > 0 && state.currentMonth % 48 == 0;
  }

  int monthsUntilElection(GameState state) {
    final remaining = 48 - (state.currentMonth % 48);
    return remaining == 48 ? 0 : remaining;
  }

  double calculatePlayerScore(GameState state) {
    double score = 0;

    score += state.stats.approvalRating * GameBalance.electionWeightApproval;
    score += state.stats.happiness * GameBalance.electionWeightHappiness;
    score += state.stats.economy * GameBalance.electionWeightEconomy;
    score += (100 - state.stats.corruption) * GameBalance.electionWeightCorruption;
    score += state.stats.stability * GameBalance.electionWeightStability;
    score += (100 - state.stats.oppositionPower) * GameBalance.electionWeightOpposition;
    score += state.stats.mediaTrust * GameBalance.electionWeightMedia;

    final keptPromises = state.activePromises.where((p) => p.isKept).length;
    final brokenPromises = state.activePromises.where((p) => p.isBroken).length;
    score += keptPromises * 2;
    score -= brokenPromises * 3;

    final randomFactor = (_random.nextDouble() - 0.5) * 10;
    score += randomFactor;

    return score.clamp(0, 100);
  }

  ElectionResult runElection(GameState state) {
    final playerScore = calculatePlayerScore(state);
    final opponentScore = 100 - playerScore + (_random.nextDouble() - 0.5) * 10;
    final normalizedPlayer = playerScore / (playerScore + opponentScore) * 100;
    final normalizedOpponent = 100 - normalizedPlayer;
    final playerWins = normalizedPlayer >= GameBalance.electionWinThreshold;

    String narrative;
    if (playerWins) {
      if (normalizedPlayer > 70) {
        narrative = 'A landslide victory! The people have spoken overwhelmingly in your favor. Your policies and leadership have earned you a resounding mandate for another term.';
      } else if (normalizedPlayer > 60) {
        narrative = 'A comfortable victory. Your record in office has convinced a solid majority that you deserve another term. The opposition concedes gracefully.';
      } else {
        narrative = 'A narrow victory. The election was closely contested, but in the end, enough voters believed in your vision to give you another chance. The opposition demands a recount.';
      }
    } else {
      if (normalizedOpponent > 70) {
        narrative = 'A devastating defeat. The voters have decisively rejected your presidency. The opposition celebrates as your supporters struggle to understand what went wrong.';
      } else if (normalizedOpponent > 60) {
        narrative = 'A clear loss. Despite your efforts, the opposition\'s message resonated more with voters. Your time as president has come to an end.';
      } else {
        narrative = 'A heartbreakingly close loss. Just a few percentage points separated you from victory. Your supporters urge you to contest the results, but the numbers are clear.';
      }
    }

    return ElectionResult(
      playerScore: normalizedPlayer,
      opponentScore: normalizedOpponent,
      playerWins: playerWins,
      narrative: narrative,
    );
  }
}

import '../models/game_state.dart';
import '../models/policy_model.dart';
import '../data/policies_data.dart';

class PolicyManager {
  List<PolicyModel> getActivePolicies(GameState state) {
    return PoliciesData.allPolicies
        .where((p) => state.activePolicyIds.contains(p.id))
        .toList();
  }

  List<PolicyModel> getAvailablePolicies(GameState state) {
    return PoliciesData.allPolicies
        .where((p) => !state.activePolicyIds.contains(p.id))
        .toList();
  }

  bool canEnactPolicy(GameState state, PolicyModel policy) {
    if (state.activePolicyIds.contains(policy.id)) return false;
    if (policy.monthlyCost > state.stats.treasury) return false;
    return true;
  }

  void enactPolicy(GameState state, PolicyModel policy) {
    if (!canEnactPolicy(state, policy)) return;
    state.activePolicyIds.add(policy.id);
    policy.isActive = true;

    state.diaryEntries.add(
      'Month ${state.currentMonth}: Enacted policy "${policy.name}"',
    );
  }

  void repealPolicy(GameState state, PolicyModel policy) {
    state.activePolicyIds.remove(policy.id);
    policy.isActive = false;

    state.diaryEntries.add(
      'Month ${state.currentMonth}: Repealed policy "${policy.name}"',
    );
  }

  void applyMonthlyPolicyEffects(GameState state) {
    double totalPolicyCost = 0;

    for (final policyId in state.activePolicyIds) {
      final policy = PoliciesData.getPolicyById(policyId);
      if (policy == null) continue;

      totalPolicyCost += policy.monthlyCost;

      for (final entry in policy.monthlyEffects.entries) {
        state.stats.applyStat(entry.key, entry.value);
      }

      for (final entry in policy.sideEffects.entries) {
        state.stats.applyStat(entry.key, entry.value);
      }
    }

    state.stats.treasury -= totalPolicyCost;
  }

  double getTotalPolicyCost(GameState state) {
    double total = 0;
    for (final policyId in state.activePolicyIds) {
      final policy = PoliciesData.getPolicyById(policyId);
      if (policy != null) total += policy.monthlyCost;
    }
    return total;
  }
}

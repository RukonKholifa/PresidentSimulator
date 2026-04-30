import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/game_state.dart';
import '../data/policies_data.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> {
  late GameState state;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      state = ModalRoute.of(context)?.settings.arguments as GameState? ?? GameState.empty();
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final policies = PoliciesData.allPolicies;

    return Scaffold(
      appBar: AppBar(title: const Text('Policies')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: policies.length,
        itemBuilder: (context, i) {
          final policy = policies[i];
          final isActive = state.activePolicyIds.contains(policy.id);

          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.cardBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: isActive ? AppTheme.accent : AppTheme.cardBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(policy.name, style: AppTheme.headerStyle(size: 14))),
                    if (isActive)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.accent.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text('ACTIVE', style: AppTheme.bodyStyle(size: 9, weight: FontWeight.w700, color: AppTheme.accent)),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(policy.description, style: AppTheme.bodyStyle(size: 11, color: AppTheme.textSecondary)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text('Cost: \$${policy.monthlyCost.toStringAsFixed(0)}/mo', style: AppTheme.bodyStyle(size: 10, color: AppTheme.warning)),
                    const Spacer(),
                    if (policy.requiresParliament)
                      Text('Requires Parliament', style: AppTheme.bodyStyle(size: 10, color: AppTheme.textSecondary)),
                  ],
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: policy.monthlyEffects.entries.map((e) {
                    final positive = e.value > 0;
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: (positive ? AppTheme.success : AppTheme.danger).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${e.key} ${positive ? "+" : ""}${e.value.toStringAsFixed(1)}',
                        style: AppTheme.bodyStyle(size: 9, color: positive ? AppTheme.success : AppTheme.danger),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      if (!isActive && policy.requiresParliament && !policy.parliamentApproved) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('This policy requires Parliament approval first. Use the Parliament Vote screen.')),
                        );
                        return;
                      }
                      setState(() {
                        if (isActive) {
                          state.activePolicyIds.remove(policy.id);
                        } else {
                          state.activePolicyIds.add(policy.id);
                        }
                      });
                    },
                    child: Text(isActive ? 'Deactivate' : (!isActive && policy.requiresParliament && !policy.parliamentApproved ? 'Needs Parliament' : 'Activate')),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

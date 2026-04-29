import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../data/strings_en.dart';
import '../managers/policy_manager.dart';

class PolicyScreen extends StatefulWidget {
  const PolicyScreen({super.key});

  @override
  State<PolicyScreen> createState() => _PolicyScreenState();
}

class _PolicyScreenState extends State<PolicyScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PolicyManager _policyManager = PolicyManager();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final active = _policyManager.getActivePolicies(state);
    final available = _policyManager.getAvailablePolicies(state);

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsEn.managePolicies),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: '${StringsEn.activePolicies} (${active.length})'),
            Tab(text: '${StringsEn.availablePolicies} (${available.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: active.isEmpty
                ? [const Center(child: Text('No active policies', style: TextStyle(color: AppTheme.textSecondary)))]
                : active.map((p) => _buildPolicyCard(state, p, isActive: true)).toList(),
          ),
          ListView(
            padding: const EdgeInsets.all(16),
            children: available.map((p) => _buildPolicyCard(state, p, isActive: false)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyCard(GameState state, policy, {required bool isActive}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(policy.name, style: const TextStyle(fontWeight: FontWeight.bold))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isActive ? AppTheme.success.withValues(alpha: 0.2) : AppTheme.primaryMid,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(isActive ? 'ACTIVE' : '\$${policy.monthlyCost.toStringAsFixed(0)}/mo', style: TextStyle(fontSize: 10, color: isActive ? AppTheme.success : AppTheme.textSecondary)),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(policy.description, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              children: policy.monthlyEffects.entries.map<Widget>((e) => Chip(
                label: Text('${e.key}: ${e.value > 0 ? '+' : ''}${e.value.toStringAsFixed(1)}', style: TextStyle(fontSize: 10, color: e.value > 0 ? AppTheme.success : AppTheme.danger)),
                backgroundColor: AppTheme.primaryMid,
                visualDensity: VisualDensity.compact,
              )).toList(),
            ),
            if (policy.requiresParliament) ...[
              const SizedBox(height: 4),
              const Text('Requires Parliament Approval', style: TextStyle(fontSize: 10, color: AppTheme.warning)),
            ],
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (isActive) {
                      _policyManager.repealPolicy(state, policy);
                    } else {
                      _policyManager.enactPolicy(state, policy);
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isActive ? AppTheme.danger : AppTheme.success,
                ),
                child: Text(isActive ? StringsEn.repealPolicy : StringsEn.enactPolicy),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

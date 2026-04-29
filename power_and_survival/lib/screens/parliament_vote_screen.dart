import 'package:flutter/material.dart';
import 'dart:math';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../data/strings_en.dart';
import '../managers/policy_manager.dart';

class ParliamentVoteScreen extends StatefulWidget {
  const ParliamentVoteScreen({super.key});

  @override
  State<ParliamentVoteScreen> createState() => _ParliamentVoteScreenState();
}

class _ParliamentVoteScreenState extends State<ParliamentVoteScreen> {
  final PolicyManager _policyManager = PolicyManager();
  String? _voteResult;

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final needsApproval = _policyManager.getAvailablePolicies(state)
        .where((p) => p.requiresParliament).toList();

    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.parliamentVote)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Parliament', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.gold)),
                  const SizedBox(height: 8),
                  Text('Your party holds ${(60 - state.stats.oppositionPower * 0.3).clamp(30, 70).toStringAsFixed(0)}% of seats', style: const TextStyle(color: AppTheme.textSecondary)),
                  Text('Opposition strength: ${state.stats.oppositionPower.toStringAsFixed(0)}%', style: const TextStyle(color: AppTheme.textSecondary)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Propose a Bill', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (needsApproval.isEmpty)
            const Text('No bills available for parliamentary vote.', style: TextStyle(color: AppTheme.textSecondary)),
          ...needsApproval.map((policy) => Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ListTile(
              title: Text(policy.name, style: const TextStyle(fontSize: 14)),
              subtitle: Text('Cost: \$${policy.monthlyCost}/mo', style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
              trailing: ElevatedButton(
                onPressed: () {
                  final supportBase = 60 - state.stats.oppositionPower * 0.3;
                  final roll = Random().nextDouble() * 100;
                  final passed = roll < supportBase;
                  setState(() {
                    if (passed) {
                      policy.parliamentApproved = true;
                      _policyManager.enactPolicy(state, policy);
                      _voteResult = '${policy.name} PASSED by parliament!';
                    } else {
                      _voteResult = '${policy.name} was REJECTED by parliament.';
                    }
                    state.diaryEntries.add('Month ${state.currentMonth}: Parliament vote on ${policy.name} — ${passed ? "Passed" : "Rejected"}');
                  });
                },
                child: const Text('Vote'),
              ),
            ),
          )),
          if (_voteResult != null) ...[
            const SizedBox(height: 16),
            Card(
              color: _voteResult!.contains('PASSED') ? AppTheme.success.withValues(alpha: 0.1) : AppTheme.danger.withValues(alpha: 0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(_voteResult!, style: TextStyle(color: _voteResult!.contains('PASSED') ? AppTheme.success : AppTheme.danger, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/game_state.dart';
import '../data/policies_data.dart';
import 'dart:math';

class ParliamentVoteScreen extends StatefulWidget {
  const ParliamentVoteScreen({super.key});

  @override
  State<ParliamentVoteScreen> createState() => _ParliamentVoteScreenState();
}

class _ParliamentVoteScreenState extends State<ParliamentVoteScreen> {
  late GameState state;
  bool _initialized = false;
  String? _selectedPolicyId;
  bool? _voteResult;
  double? _votePercent;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      state = ModalRoute.of(context)?.settings.arguments as GameState? ?? GameState.empty();
      _initialized = true;
    }
  }

  void _holdVote() {
    if (_selectedPolicyId == null) return;
    final baseSupport = (state.stats.approvalRating + state.stats.stability) / 2;
    final opposition = state.stats.oppositionPower;
    final support = baseSupport - opposition * 0.3 + Random().nextDouble() * 10 - 5;
    final percent = support.clamp(0.0, 100.0);
    final passed = percent > 50;

    if (passed) {
      if (!state.activePolicyIds.contains(_selectedPolicyId!)) {
        state.activePolicyIds.add(_selectedPolicyId!);
      }
    } else {
      state.stats.approvalRating -= 2;
    }

    setState(() {
      _votePercent = percent;
      _voteResult = passed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pending = PoliciesData.allPolicies
        .where((p) => p.requiresParliament && !state.activePolicyIds.contains(p.id))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Parliament Vote')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Propose Legislation', style: AppTheme.headerStyle(size: 18)),
            const SizedBox(height: 12),
            if (_voteResult == null) ...[
              if (pending.isEmpty)
                Text('No pending legislation.', style: AppTheme.bodyStyle(size: 12, color: AppTheme.textSecondary))
              else ...[
                ...pending.map((p) => RadioListTile<String>(
                  title: Text(p.name, style: AppTheme.bodyStyle(size: 13)),
                  subtitle: Text(p.description, style: AppTheme.bodyStyle(size: 10, color: AppTheme.textSecondary)),
                  value: p.id,
                  groupValue: _selectedPolicyId,
                  onChanged: (v) => setState(() => _selectedPolicyId = v),
                  activeColor: AppTheme.accent,
                )),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedPolicyId != null ? _holdVote : null,
                    child: const Text('Call Vote'),
                  ),
                ),
              ],
            ] else ...[
              Center(
                child: Column(
                  children: [
                    Icon(
                      _voteResult! ? Icons.check_circle : Icons.cancel,
                      size: 60,
                      color: _voteResult! ? AppTheme.success : AppTheme.danger,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _voteResult! ? 'PASSED' : 'REJECTED',
                      style: AppTheme.headerStyle(size: 24).copyWith(color: _voteResult! ? AppTheme.success : AppTheme.danger),
                    ),
                    Text('${_votePercent!.toStringAsFixed(1)}% support', style: AppTheme.bodyStyle(size: 14)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

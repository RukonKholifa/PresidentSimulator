import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../data/strings_en.dart';
import '../managers/budget_manager.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late Map<String, double> _allocation;
  final BudgetManager _budgetManager = BudgetManager();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state != null) {
      _allocation = Map.from(state.budgetAllocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final income = _budgetManager.getMonthlyIncome(state);

    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.budgetAllocation)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Monthly Income:', style: TextStyle(color: AppTheme.textSecondary)),
                      Text('\$${income.toStringAsFixed(0)}M', style: const TextStyle(color: AppTheme.success, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Treasury:', style: TextStyle(color: AppTheme.textSecondary)),
                      Text('\$${state.stats.treasury.toStringAsFixed(0)}M', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Debt:', style: TextStyle(color: AppTheme.textSecondary)),
                      Text('\$${state.stats.debt.toStringAsFixed(0)}M', style: TextStyle(color: state.stats.debt > 0 ? AppTheme.danger : AppTheme.textPrimary, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          ...BudgetManager.budgetCategories.entries.map((entry) {
            final value = _allocation[entry.key] ?? 0;
            return _buildSlider(entry.value, entry.key, value);
          }),
          const SizedBox(height: 8),
          _buildTotalIndicator(),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                state.budgetAllocation = _budgetManager.normalizeBudget(_allocation);
                state.diaryEntries.add('Month ${state.currentMonth}: Adjusted budget allocation');
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accent),
              child: const Text(StringsEn.saveBudget),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, String key, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 13)),
              Text('${(value * 100).toStringAsFixed(0)}%', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
          Slider(
            value: value,
            min: 0, max: 0.5,
            divisions: 50,
            onChanged: (v) => setState(() => _allocation[key] = v),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalIndicator() {
    final total = _allocation.values.fold(0.0, (sum, v) => sum + v);
    final isValid = (total - 1.0).abs() < 0.02;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isValid ? AppTheme.success.withValues(alpha: 0.1) : AppTheme.danger.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Total Allocation:', style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            '${(total * 100).toStringAsFixed(0)}%',
            style: TextStyle(fontWeight: FontWeight.bold, color: isValid ? AppTheme.success : AppTheme.danger),
          ),
        ],
      ),
    );
  }
}

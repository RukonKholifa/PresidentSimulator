import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/game_state.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  late GameState state;
  bool _initialized = false;

  final _categories = [
    ('health', 'Healthcare', Icons.local_hospital),
    ('education', 'Education', Icons.school),
    ('military', 'Military', Icons.military_tech),
    ('security', 'Police & Security', Icons.shield),
    ('infrastructure', 'Infrastructure', Icons.construction),
    ('welfare', 'Welfare', Icons.people),
    ('reserve', 'Media & Reserve', Icons.campaign),
    ('debt_payment', 'Debt Payment', Icons.money_off),
    ('foreign_affairs', 'Foreign Affairs', Icons.public),
    ('intelligence', 'Intelligence', Icons.visibility),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      state = ModalRoute.of(context)?.settings.arguments as GameState? ?? GameState.empty();
      _initialized = true;
    }
  }

  double get _totalAllocation => state.budgetAllocation.values.fold(0.0, (a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget Allocation')),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: AppTheme.cardBackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Treasury: \$${state.stats.treasury.toStringAsFixed(0)}M', style: AppTheme.headerStyle(size: 14)),
                Text('Allocated: ${(_totalAllocation * 100).toStringAsFixed(0)}%',
                  style: AppTheme.bodyStyle(size: 12, color: _totalAllocation > 1.01 ? AppTheme.danger : AppTheme.success)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _categories.length,
              itemBuilder: (context, i) {
                final cat = _categories[i];
                final val = state.budgetAllocation[cat.$1] ?? 0;
                return _budgetRow(cat.$1, cat.$2, cat.$3, val);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Confirm Budget'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _budgetRow(String key, String label, IconData icon, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: AppTheme.cardDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: AppTheme.accent),
                const SizedBox(width: 8),
                Text(label, style: AppTheme.bodyStyle(size: 12, weight: FontWeight.w600)),
                const Spacer(),
                Text('${(value * 100).toStringAsFixed(0)}%', style: AppTheme.headerStyle(size: 14)),
              ],
            ),
            Slider(
              value: value,
              min: 0,
              max: 0.40,
              divisions: 40,
              onChanged: (v) {
                setState(() {
                  state.budgetAllocation[key] = v;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

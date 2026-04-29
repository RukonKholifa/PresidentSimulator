import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';

class MonthlyReportScreen extends StatelessWidget {
  const MonthlyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    return Scaffold(
      appBar: AppBar(title: Text('${StringsEn.monthlyReport} — ${state.monthName}')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Month ${state.currentMonth} Summary', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.gold)),
                    const SizedBox(height: 12),
                    _statRow('Treasury', '\$${state.stats.treasury.toStringAsFixed(0)}M', state.stats.treasury > 200 ? AppTheme.success : AppTheme.danger),
                    _statRow('Debt', '\$${state.stats.debt.toStringAsFixed(0)}M', state.stats.debt > 500 ? AppTheme.danger : AppTheme.success),
                    _statRow('Approval', '${state.stats.approvalRating.toStringAsFixed(0)}%', AppTheme.getStatColor(state.stats.approvalRating)),
                    _statRow('Stability', '${state.stats.stability.toStringAsFixed(0)}', AppTheme.getStatColor(state.stats.stability)),
                    _statRow('Happiness', '${state.stats.happiness.toStringAsFixed(0)}', AppTheme.getStatColor(state.stats.happiness)),
                    _statRow('Economy', '${state.stats.economy.toStringAsFixed(0)}', AppTheme.getStatColor(state.stats.economy)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (state.newsHistory.isNotEmpty) ...[
              const Text('Headlines This Month', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...state.newsHistory.reversed.take(5).map((h) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: AppTheme.accent)),
                    Expanded(child: Text(h, style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
                  ],
                ),
              )),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.dashboard, arguments: state),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accent, padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text(StringsEn.continueToNextMonth),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppTheme.textSecondary)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

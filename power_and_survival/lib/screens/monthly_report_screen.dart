import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../models/game_state.dart';

class MonthlyReportScreen extends StatelessWidget {
  const MonthlyReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error: No data')));

    final monthNames = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final mi = ((state.currentMonth - 1) % 12);
    final year = state.currentYear + ((state.currentMonth - 1) ~/ 12);

    return Scaffold(
      appBar: AppBar(title: Text('Monthly Report — ${monthNames[mi]} $year')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: AppTheme.cardDecoration,
              child: Column(
                children: [
                  Text('Approval: ${state.stats.approvalRating.toStringAsFixed(1)}%',
                    style: AppTheme.headerStyle(size: 22).copyWith(color: AppTheme.getStatColor(state.stats.approvalRating))),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _miniStat('Treasury', '\$${state.stats.treasury.toStringAsFixed(0)}M', state.stats.treasury > 0 ? AppTheme.success : AppTheme.danger),
                      _miniStat('Debt', '\$${state.stats.debt.toStringAsFixed(0)}M', state.stats.debt > 500 ? AppTheme.danger : AppTheme.textSecondary),
                      _miniStat('Stability', '${state.stats.stability.toStringAsFixed(0)}', AppTheme.getStatColor(state.stats.stability)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text('News This Month', style: AppTheme.headerStyle(size: 16)),
            const SizedBox(height: 8),
            if (state.newsHistory.isNotEmpty)
              ...state.newsHistory.reversed.take(5).map((n) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(color: AppTheme.accent)),
                    Expanded(child: Text(n, style: AppTheme.bodyStyle(size: 12))),
                  ],
                ),
              ))
            else
              Text('No news this month.', style: AppTheme.bodyStyle(size: 12, color: AppTheme.textSecondary)),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.dashboard, arguments: state),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _miniStat(String label, String value, Color color) {
    return Column(
      children: [
        Text(value, style: AppTheme.headerStyle(size: 16).copyWith(color: color)),
        Text(label, style: AppTheme.bodyStyle(size: 10, color: AppTheme.textSecondary)),
      ],
    );
  }
}

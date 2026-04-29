import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../models/game_state.dart';
import '../widgets/promise_item_widget.dart';

class PromiseTrackerScreen extends StatelessWidget {
  const PromiseTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    final promises = state?.activePromises ?? [];

    return Scaffold(
      appBar: AppBar(title: const Text('Promise Tracker')),
      body: promises.isEmpty
          ? Center(child: Text('No active promises.', style: AppTheme.bodyStyle(size: 14, color: AppTheme.textSecondary)))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: promises.length,
              itemBuilder: (context, i) => PromiseItemWidget(
                promise: promises[i],
                currentMonth: state!.currentMonth,
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../data/strings_en.dart';
import '../widgets/promise_item_widget.dart';

class PromiseTrackerScreen extends StatelessWidget {
  const PromiseTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;
    if (state == null) return const Scaffold(body: Center(child: Text('Error')));

    final active = state.activePromises.where((p) => !p.isKept && !p.isBroken).toList();
    final kept = state.activePromises.where((p) => p.isKept).toList();
    final broken = state.activePromises.where((p) => p.isBroken).toList();

    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.promiseTracker)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (active.isEmpty && kept.isEmpty && broken.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text('No promises yet. Make decisions during events to create promises.', style: TextStyle(color: AppTheme.textSecondary), textAlign: TextAlign.center),
              ),
            ),
          if (active.isNotEmpty) ...[
            const Text(StringsEn.activePromises, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...active.map((p) => PromiseItemWidget(promise: p, currentMonth: state.currentMonth)),
            const SizedBox(height: 16),
          ],
          if (kept.isNotEmpty) ...[
            const Text(StringsEn.keptPromises, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.success)),
            ...kept.map((p) => PromiseItemWidget(promise: p, currentMonth: state.currentMonth)),
            const SizedBox(height: 16),
          ],
          if (broken.isNotEmpty) ...[
            const Text(StringsEn.brokenPromises, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.danger)),
            ...broken.map((p) => PromiseItemWidget(promise: p, currentMonth: state.currentMonth)),
          ],
        ],
      ),
    );
  }
}

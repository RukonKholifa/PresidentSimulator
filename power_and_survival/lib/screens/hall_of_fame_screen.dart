import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../managers/save_manager.dart';

class HallOfFameScreen extends StatelessWidget {
  const HallOfFameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final records = SaveManager().loadHallOfFame();

    return Scaffold(
      appBar: AppBar(title: const Text('Hall of Fame')),
      body: records.isEmpty
          ? Center(child: Text('No records yet. Complete a game!', style: AppTheme.bodyStyle(size: 14, color: AppTheme.textSecondary)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: records.length,
              itemBuilder: (context, i) {
                final r = records[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: AppTheme.cardDecoration,
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i == 0 ? AppTheme.accent : AppTheme.cardBorder,
                        ),
                        child: Center(child: Text('#${i + 1}', style: AppTheme.bodyStyle(size: 12, weight: FontWeight.w700))),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(r.presidentName, style: AppTheme.headerStyle(size: 14)),
                            Text('${r.monthsInPower} months | ${r.endingType}',
                              style: AppTheme.bodyStyle(size: 11, color: AppTheme.textSecondary)),
                          ],
                        ),
                      ),
                      Text('${r.score}pts', style: AppTheme.headerStyle(size: 14).copyWith(color: AppTheme.accent)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

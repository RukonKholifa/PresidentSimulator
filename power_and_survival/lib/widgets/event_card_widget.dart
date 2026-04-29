import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../config/theme.dart';

class EventCardWidget extends StatelessWidget {
  final EventModel event;
  final void Function(EventChoice choice) onChoiceSelected;

  const EventCardWidget({
    super.key,
    required this.event,
    required this.onChoiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: AppTheme.cardDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title, style: AppTheme.headerStyle(size: 20)),
                const SizedBox(height: 8),
                Text(event.description, style: AppTheme.bodyStyle(size: 13)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text('Choose your response:', style: AppTheme.headerStyle(size: 16)),
          const SizedBox(height: 8),
          ...event.choices.map((choice) => _buildChoiceCard(choice)),
        ],
      ),
    );
  }

  Widget _buildChoiceCard(EventChoice choice) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppTheme.cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppTheme.cardBorder),
        ),
        child: InkWell(
          onTap: () => onChoiceSelected(choice),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(choice.text, style: AppTheme.bodyStyle(size: 13)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: [
                    ...choice.statEffects.entries.map((e) => _effectChip(e.key, e.value)),
                    if (choice.treasuryCost != null && choice.treasuryCost! > 0)
                      _effectChip('Cost', -choice.treasuryCost!),
                    if (choice.debtIncrease != null && choice.debtIncrease! > 0)
                      _effectChip('Debt', choice.debtIncrease!),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _effectChip(String stat, double value) {
    final isPositive = stat == 'corruption' || stat == 'crime' || stat == 'debt' || stat == 'oppositionPower'
        ? value < 0
        : value > 0;
    final color = isPositive ? AppTheme.success : AppTheme.danger;
    final sign = value > 0 ? '+' : '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '$stat $sign${value.toStringAsFixed(0)}',
        style: AppTheme.bodyStyle(size: 10, weight: FontWeight.w600, color: color),
      ),
    );
  }
}

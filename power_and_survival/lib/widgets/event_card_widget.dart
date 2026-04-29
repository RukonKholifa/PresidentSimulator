import 'package:flutter/material.dart';
import '../models/event_model.dart';
import '../config/theme.dart';

class EventCardWidget extends StatelessWidget {
  final EventModel event;
  final void Function(EventChoice choice)? onChoiceSelected;

  const EventCardWidget({
    super.key,
    required this.event,
    this.onChoiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryBadge(),
            const SizedBox(height: 12),
            Text(
              event.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              event.description,
              style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 20),
            const Divider(color: AppTheme.primaryLight),
            const SizedBox(height: 12),
            const Text(
              'Choose your response:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...event.choices.map((choice) => _buildChoiceButton(context, choice)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBadge() {
    final color = _getCategoryColor(event.category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        event.category.toUpperCase(),
        style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildChoiceButton(BuildContext context, EventChoice choice) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => onChoiceSelected?.call(choice),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: AppTheme.primaryLight),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                choice.text,
                style: const TextStyle(fontSize: 13, height: 1.4),
              ),
              if (choice.treasuryCost != null) ...[
                const SizedBox(height: 4),
                Text(
                  'Cost: \$${choice.treasuryCost!.abs().toStringAsFixed(0)}M',
                  style: TextStyle(
                    fontSize: 11,
                    color: choice.treasuryCost! > 0 ? AppTheme.danger : AppTheme.success,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    return switch (category) {
      'economic' => AppTheme.gold,
      'social' => AppTheme.info,
      'political' => AppTheme.accent,
      'security' => AppTheme.danger,
      'protest' => AppTheme.warning,
      'environmental' => AppTheme.success,
      'international' => AppTheme.info,
      'character' => AppTheme.accent,
      _ => AppTheme.textSecondary,
    };
  }
}

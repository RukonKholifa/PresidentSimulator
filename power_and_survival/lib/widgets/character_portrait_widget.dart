import 'package:flutter/material.dart';
import '../models/character.dart';
import '../config/theme.dart';

class CharacterPortraitWidget extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;
  final bool showWarning;

  const CharacterPortraitWidget({
    super.key,
    required this.character,
    this.onTap,
    this.showWarning = true,
  });

  IconData _roleIcon() {
    return switch (character.role) {
      'army_chief' => Icons.military_tech,
      'finance_minister' => Icons.account_balance,
      'intelligence_chief' => Icons.visibility,
      'interior_minister' => Icons.security,
      'foreign_minister' => Icons.public,
      'health_minister' => Icons.local_hospital,
      'education_minister' => Icons.school,
      'media_director' => Icons.campaign,
      'business_tycoon' => Icons.business,
      'opposition_leader' => Icons.front_hand,
      _ => Icons.person,
    };
  }

  bool get _hasDanger =>
      character.loyalty < 35 ||
      character.ambition > 70 ||
      character.monthsDisloyal > 2 ||
      character.currentDemands.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final loyaltyColor = AppTheme.getStatColor(character.loyalty);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hasDanger && showWarning ? AppTheme.danger.withValues(alpha: 0.6) : AppTheme.cardBorder,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: loyaltyColor, width: 3),
                    color: AppTheme.background,
                  ),
                  child: Icon(_roleIcon(), size: 22, color: AppTheme.textPrimary),
                ),
                if (_hasDanger && showWarning)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: const BoxDecoration(
                        color: AppTheme.danger,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.priority_high, size: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              character.name.split(' ').first,
              style: AppTheme.bodyStyle(size: 11, weight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              character.role.replaceAll('_', ' '),
              style: AppTheme.bodyStyle(size: 9, color: AppTheme.textSecondary),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 40,
              height: 4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: (character.loyalty / 100).clamp(0.0, 1.0),
                  backgroundColor: AppTheme.cardBorder,
                  color: loyaltyColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

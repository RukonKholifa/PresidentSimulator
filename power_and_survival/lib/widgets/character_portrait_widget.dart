import 'package:flutter/material.dart';
import '../models/character.dart';
import '../config/theme.dart';
import '../data/characters_data.dart';

class CharacterPortraitWidget extends StatelessWidget {
  final Character character;
  final VoidCallback? onTap;

  const CharacterPortraitWidget({
    super.key,
    required this.character,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final loyaltyColor = AppTheme.getStatColor(character.loyalty);
    final roleName = CharactersData.roleDisplayNames[character.role] ?? character.role;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: loyaltyColor.withValues(alpha: 0.2),
                child: Icon(
                  _getRoleIcon(character.role),
                  color: loyaltyColor,
                  size: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                character.name,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                roleName,
                style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite, size: 12, color: loyaltyColor),
                  const SizedBox(width: 4),
                  Text(
                    character.loyalty.toStringAsFixed(0),
                    style: TextStyle(fontSize: 11, color: loyaltyColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getRoleIcon(String role) {
    return switch (role) {
      'vice_president' => Icons.account_balance,
      'army_chief' => Icons.military_tech,
      'finance_minister' => Icons.attach_money,
      'intelligence_chief' => Icons.visibility,
      'interior_minister' => Icons.security,
      'foreign_minister' => Icons.public,
      'media_advisor' => Icons.campaign,
      'party_leader' => Icons.groups,
      'business_tycoon' => Icons.business,
      'student_leader' => Icons.school,
      _ => Icons.person,
    };
  }
}

import 'package:flutter/material.dart';
import '../models/character.dart';
import '../config/theme.dart';
import '../data/characters_data.dart';

class AdvisorCommentWidget extends StatelessWidget {
  final Character advisor;
  final String comment;

  const AdvisorCommentWidget({
    super.key,
    required this.advisor,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final roleName = CharactersData.roleDisplayNames[advisor.role] ?? advisor.role;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppTheme.primaryLight,
              child: Text(
                advisor.name.isNotEmpty ? advisor.name[0] : '?',
                style: const TextStyle(color: AppTheme.textPrimary, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        advisor.name,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        roleName,
                        style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '"$comment"',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

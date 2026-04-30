import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';
import '../managers/save_manager.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.accent, width: 2),
                  ),
                  child: const Icon(Icons.account_balance, size: 32, color: AppTheme.accent),
                ),
                const SizedBox(height: 16),
                Text('Power & Survival', style: AppTheme.headerStyle(size: 26)),
                Text('President Simulator', style: AppTheme.bodyStyle(size: 12, color: AppTheme.textSecondary)),
                const SizedBox(height: 40),
                _menuButton(context, 'New Game', Icons.play_arrow, () {
                  Navigator.pushNamed(context, AppRoutes.newGame);
                }),
                const SizedBox(height: 12),
                _menuButton(context, 'Continue', Icons.save, () async {
                  final saveManager = SaveManager();
                  final state = await saveManager.loadAutoSave();
                  if (state != null && context.mounted) {
                    Navigator.pushReplacementNamed(context, AppRoutes.dashboard, arguments: state);
                  } else if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No save found')),
                    );
                  }
                }),
                const SizedBox(height: 12),
                _menuButton(context, 'Hall of Fame', Icons.emoji_events, () {
                  Navigator.pushNamed(context, AppRoutes.hallOfFame);
                }),
                const SizedBox(height: 12),
                _menuButton(context, 'Achievements', Icons.star, () {
                  Navigator.pushNamed(context, AppRoutes.achievements);
                }),
                const SizedBox(height: 12),
                _menuButton(context, 'Settings', Icons.settings, () {
                  Navigator.pushNamed(context, AppRoutes.settings);
                }),
                const SizedBox(height: 24),
                Text(StringsEn.createdBy, style: AppTheme.bodyStyle(size: 11, color: AppTheme.textSecondary)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 20),
        label: Text(label),
      ),
    );
  }
}

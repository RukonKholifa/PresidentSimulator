import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';
import '../managers/save_manager.dart';

class MainMenuScreen extends StatefulWidget {
  const MainMenuScreen({super.key});

  @override
  State<MainMenuScreen> createState() => _MainMenuScreenState();
}

class _MainMenuScreenState extends State<MainMenuScreen> {
  final SaveManager _saveManager = SaveManager();
  bool _hasSave = false;

  @override
  void initState() {
    super.initState();
    _checkSave();
  }

  Future<void> _checkSave() async {
    final hasSave = await _saveManager.hasSavedGame();
    if (mounted) setState(() => _hasSave = hasSave);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.account_balance, size: 64, color: AppTheme.gold)
                    .animate().fadeIn(duration: 600.ms),
                const SizedBox(height: 16),
                const Text(
                  StringsEn.appTitle,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.gold),
                ).animate().fadeIn(delay: 200.ms),
                const Text(
                  StringsEn.appSubtitle,
                  style: TextStyle(fontSize: 14, color: AppTheme.textSecondary),
                ).animate().fadeIn(delay: 300.ms),
                const SizedBox(height: 48),
                _menuButton(StringsEn.newGame, Icons.add, () {
                  Navigator.pushNamed(context, AppRoutes.newGame);
                }).animate().fadeIn(delay: 400.ms).slideX(begin: -0.2),
                if (_hasSave)
                  _menuButton(StringsEn.continueGame, Icons.play_arrow, () async {
                    final state = await _saveManager.loadGame();
                    if (state != null && mounted) {
                      Navigator.pushNamed(context, AppRoutes.dashboard, arguments: state);
                    }
                  }).animate().fadeIn(delay: 500.ms).slideX(begin: -0.2),
                _menuButton(StringsEn.hallOfFame, Icons.emoji_events, () {
                  Navigator.pushNamed(context, AppRoutes.hallOfFame);
                }).animate().fadeIn(delay: 600.ms).slideX(begin: -0.2),
                _menuButton(StringsEn.achievements, Icons.star, () {
                  Navigator.pushNamed(context, AppRoutes.achievements);
                }).animate().fadeIn(delay: 700.ms).slideX(begin: -0.2),
                _menuButton(StringsEn.settings, Icons.settings, () {
                  Navigator.pushNamed(context, AppRoutes.settings);
                }).animate().fadeIn(delay: 800.ms).slideX(begin: -0.2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuButton(String text, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(icon),
          label: Text(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: AppTheme.primaryMid,
          ),
        ),
      ),
    );
  }
}

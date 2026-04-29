import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../managers/save_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _soundEnabled = true;
  bool _musicEnabled = true;
  bool _tutorialEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _toggle('Sound Effects', _soundEnabled, (v) => setState(() => _soundEnabled = v)),
          _toggle('Background Music', _musicEnabled, (v) => setState(() => _musicEnabled = v)),
          _toggle('Show Tutorial', _tutorialEnabled, (v) => setState(() => _tutorialEnabled = v)),
          const SizedBox(height: 20),
          Text('Save Slots', style: AppTheme.headerStyle(size: 16)),
          const SizedBox(height: 10),
          _saveSlot(0, 'Slot 1'),
          _saveSlot(1, 'Slot 2'),
          _saveSlot(2, 'Slot 3'),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainMenu, (_) => false);
            },
            style: OutlinedButton.styleFrom(foregroundColor: AppTheme.danger, side: const BorderSide(color: AppTheme.danger)),
            child: const Text('Quit to Menu'),
          ),
        ],
      ),
    );
  }

  Widget _toggle(String label, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: AppTheme.cardDecoration,
      child: SwitchListTile(
        title: Text(label, style: AppTheme.bodyStyle(size: 13)),
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.accent,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  Widget _saveSlot(int slot, String label) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: AppTheme.cardDecoration,
      child: Row(
        children: [
          const Icon(Icons.save, size: 18, color: AppTheme.textSecondary),
          const SizedBox(width: 10),
          Expanded(child: Text(label, style: AppTheme.bodyStyle(size: 13))),
          TextButton(
            onPressed: () async {
              final state = await SaveManager().loadGame(slot);
              if (state != null && mounted) {
                Navigator.pushReplacementNamed(context, AppRoutes.dashboard, arguments: state);
              }
            },
            child: const Text('Load'),
          ),
          TextButton(
            onPressed: () => SaveManager().deleteSave(slot),
            child: Text('Delete', style: TextStyle(color: AppTheme.danger)),
          ),
        ],
      ),
    );
  }
}

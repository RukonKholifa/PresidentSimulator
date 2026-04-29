import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';
import '../managers/save_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double _musicVolume = 0.7;
  double _sfxVolume = 0.8;
  bool _soundEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settings = await SaveManager().loadSettings();
    if (mounted) {
      setState(() {
        _musicVolume = (settings['musicVolume'] as num?)?.toDouble() ?? 0.7;
        _sfxVolume = (settings['sfxVolume'] as num?)?.toDouble() ?? 0.8;
        _soundEnabled = settings['soundEnabled'] as bool? ?? true;
      });
    }
  }

  Future<void> _saveSettings() async {
    await SaveManager().saveSettings({
      'musicVolume': _musicVolume,
      'sfxVolume': _sfxVolume,
      'soundEnabled': _soundEnabled,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.settings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text(StringsEn.soundEffects),
            value: _soundEnabled,
            onChanged: (v) { setState(() => _soundEnabled = v); _saveSettings(); },
            activeColor: AppTheme.accent,
          ),
          ListTile(
            title: const Text(StringsEn.musicVolume),
            subtitle: Slider(
              value: _musicVolume,
              onChanged: (v) { setState(() => _musicVolume = v); _saveSettings(); },
            ),
            trailing: Text('${(_musicVolume * 100).toStringAsFixed(0)}%'),
          ),
          ListTile(
            title: const Text(StringsEn.sfxVolume),
            subtitle: Slider(
              value: _sfxVolume,
              onChanged: (v) { setState(() => _sfxVolume = v); _saveSettings(); },
            ),
            trailing: Text('${(_sfxVolume * 100).toStringAsFixed(0)}%'),
          ),
          const Divider(),
          ListTile(
            title: const Text(StringsEn.resetProgress, style: TextStyle(color: AppTheme.danger)),
            leading: const Icon(Icons.delete_forever, color: AppTheme.danger),
            onTap: () => showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Reset All Progress?'),
                content: const Text('This will delete all saves, hall of fame entries, and achievements.'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx), child: const Text(StringsEn.cancel)),
                  TextButton(
                    onPressed: () async {
                      await SaveManager().resetAllProgress();
                      if (ctx.mounted) Navigator.pop(ctx);
                      if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainMenu, (_) => false);
                    },
                    child: const Text(StringsEn.confirm, style: TextStyle(color: AppTheme.danger)),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text(StringsEn.about),
            subtitle: const Text('Power & Survival: President Simulator\n${StringsEn.version}', style: TextStyle(color: AppTheme.textSecondary)),
            leading: const Icon(Icons.info_outline),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainMenu, (_) => false),
              icon: const Icon(Icons.home),
              label: const Text(StringsEn.mainMenu),
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryMid),
            ),
          ),
        ],
      ),
    );
  }
}

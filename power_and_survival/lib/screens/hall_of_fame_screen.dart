import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../data/strings_en.dart';
import '../managers/save_manager.dart';

class HallOfFameScreen extends StatefulWidget {
  const HallOfFameScreen({super.key});

  @override
  State<HallOfFameScreen> createState() => _HallOfFameScreenState();
}

class _HallOfFameScreenState extends State<HallOfFameScreen> {
  List<Map<String, dynamic>> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final entries = await SaveManager().loadHallOfFame();
    if (mounted) setState(() => _entries = entries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.hallOfFameTitle)),
      body: _entries.isEmpty
          ? const Center(child: Text(StringsEn.noRecords, style: TextStyle(color: AppTheme.textSecondary)))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _entries.length,
              itemBuilder: (context, index) {
                final entry = _entries[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: index < 3 ? AppTheme.gold : AppTheme.primaryLight,
                      child: Text('${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    title: Text('${entry['name']} of ${entry['country']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${entry['months']} months • ${(entry['approval'] as num?)?.toStringAsFixed(0) ?? '0'}% approval', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                    trailing: Text('${(entry['score'] as num?)?.toStringAsFixed(0) ?? '0'}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.gold)),
                  ),
                );
              },
            ),
    );
  }
}

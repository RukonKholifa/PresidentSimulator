import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_state.dart';

class SaveManager {
  static const String _saveKey = 'game_save';
  static const String _hallOfFameKey = 'hall_of_fame';
  static const String _settingsKey = 'game_settings';

  Future<void> saveGame(GameState state) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(state.toJson());
    await prefs.setString(_saveKey, json);
  }

  Future<GameState?> loadGame() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_saveKey);
    if (json == null) return null;
    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      return GameState.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  Future<bool> hasSavedGame() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_saveKey);
  }

  Future<void> deleteSave() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_saveKey);
  }

  Future<void> saveToHallOfFame(Map<String, dynamic> entry) async {
    final prefs = await SharedPreferences.getInstance();
    final existing = prefs.getString(_hallOfFameKey);
    List<dynamic> entries = [];
    if (existing != null) {
      entries = jsonDecode(existing) as List<dynamic>;
    }
    entries.add(entry);
    entries.sort((a, b) => (b['score'] as num).compareTo(a['score'] as num));
    if (entries.length > 20) entries = entries.sublist(0, 20);
    await prefs.setString(_hallOfFameKey, jsonEncode(entries));
  }

  Future<List<Map<String, dynamic>>> loadHallOfFame() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_hallOfFameKey);
    if (json == null) return [];
    try {
      final list = jsonDecode(json) as List<dynamic>;
      return list.map((e) => e as Map<String, dynamic>).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> saveSettings(Map<String, dynamic> settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_settingsKey, jsonEncode(settings));
  }

  Future<Map<String, dynamic>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_settingsKey);
    if (json == null) {
      return {'musicVolume': 0.7, 'sfxVolume': 0.8, 'soundEnabled': true};
    }
    try {
      return jsonDecode(json) as Map<String, dynamic>;
    } catch (_) {
      return {'musicVolume': 0.7, 'sfxVolume': 0.8, 'soundEnabled': true};
    }
  }

  Future<void> resetAllProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_saveKey);
    await prefs.remove(_hallOfFameKey);
  }
}

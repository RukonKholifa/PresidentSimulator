import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/game_state.dart';

class PresidentRecord {
  final String presidentName;
  final String countryName;
  final int monthsInPower;
  final double finalApproval;
  final String endingType;
  final int score;
  final DateTime playedAt;

  PresidentRecord({
    required this.presidentName,
    required this.countryName,
    required this.monthsInPower,
    required this.finalApproval,
    required this.endingType,
    required this.score,
    required this.playedAt,
  });

  Map<String, dynamic> toJson() => {
    'presidentName': presidentName,
    'countryName': countryName,
    'monthsInPower': monthsInPower,
    'finalApproval': finalApproval,
    'endingType': endingType,
    'score': score,
    'playedAt': playedAt.toIso8601String(),
  };

  factory PresidentRecord.fromJson(Map<String, dynamic> json) => PresidentRecord(
    presidentName: json['presidentName'] as String? ?? 'Unknown',
    countryName: json['countryName'] as String? ?? 'Unknown',
    monthsInPower: json['monthsInPower'] as int? ?? 0,
    finalApproval: (json['finalApproval'] as num?)?.toDouble() ?? 0,
    endingType: json['endingType'] as String? ?? 'unknown',
    score: json['score'] as int? ?? 0,
    playedAt: DateTime.tryParse(json['playedAt'] as String? ?? '') ?? DateTime.now(),
  );
}

class GameSettings {
  bool soundEnabled;
  bool musicEnabled;
  bool tutorialEnabled;
  double musicVolume;
  double sfxVolume;

  GameSettings({
    this.soundEnabled = true,
    this.musicEnabled = true,
    this.tutorialEnabled = true,
    this.musicVolume = 0.7,
    this.sfxVolume = 0.8,
  });

  Map<String, dynamic> toJson() => {
    'soundEnabled': soundEnabled,
    'musicEnabled': musicEnabled,
    'tutorialEnabled': tutorialEnabled,
    'musicVolume': musicVolume,
    'sfxVolume': sfxVolume,
  };

  factory GameSettings.fromJson(Map<String, dynamic> json) => GameSettings(
    soundEnabled: json['soundEnabled'] as bool? ?? true,
    musicEnabled: json['musicEnabled'] as bool? ?? true,
    tutorialEnabled: json['tutorialEnabled'] as bool? ?? true,
    musicVolume: (json['musicVolume'] as num?)?.toDouble() ?? 0.7,
    sfxVolume: (json['sfxVolume'] as num?)?.toDouble() ?? 0.8,
  );
}

class SaveInfo {
  final String presidentName;
  final String countryName;
  final int month;
  final double approval;
  final DateTime savedAt;

  SaveInfo({
    required this.presidentName,
    required this.countryName,
    required this.month,
    required this.approval,
    required this.savedAt,
  });
}

class SaveManager {
  static const String _gameSavesBox = 'game_saves';
  static const String _autoSaveBox = 'auto_save';
  static const String _hallOfFameBox = 'hall_of_fame';
  static const String _achievementsBox = 'achievements';
  static const String _settingsBox = 'settings';

  static Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(_gameSavesBox);
    await Hive.openBox<String>(_autoSaveBox);
    await Hive.openBox<String>(_hallOfFameBox);
    await Hive.openBox<String>(_achievementsBox);
    await Hive.openBox<String>(_settingsBox);
  }

  // --- Save Game (3 manual slots: 0, 1, 2) ---

  Future<void> saveGame(GameState state, int slot) async {
    assert(slot >= 0 && slot < 3, 'Slot must be 0, 1, or 2');
    final box = Hive.box<String>(_gameSavesBox);
    final json = jsonEncode(state.toJson());
    await box.put('slot_$slot', json);
    await box.put('slot_${slot}_time', DateTime.now().toIso8601String());
  }

  Future<void> autoSave(GameState state) async {
    final box = Hive.box<String>(_autoSaveBox);
    final json = jsonEncode(state.toJson());
    await box.put('auto', json);
    await box.put('auto_time', DateTime.now().toIso8601String());
  }

  Future<GameState?> loadGame(int slot) async {
    assert(slot >= 0 && slot < 3, 'Slot must be 0, 1, or 2');
    final box = Hive.box<String>(_gameSavesBox);
    final json = box.get('slot_$slot');
    if (json == null) return null;
    try {
      return GameState.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  Future<GameState?> loadAutoSave() async {
    final box = Hive.box<String>(_autoSaveBox);
    final json = box.get('auto');
    if (json == null) return null;
    try {
      return GameState.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  SaveInfo? getSaveInfo(int slot) {
    assert(slot >= 0 && slot < 3, 'Slot must be 0, 1, or 2');
    final box = Hive.box<String>(_gameSavesBox);
    final json = box.get('slot_$slot');
    if (json == null) return null;
    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      final timeStr = box.get('slot_${slot}_time') ?? '';
      return SaveInfo(
        presidentName: map['presidentName'] as String? ?? 'Unknown',
        countryName: map['countryName'] as String? ?? 'Unknown',
        month: map['currentMonth'] as int? ?? 0,
        approval: (map['stats']?['approvalRating'] as num?)?.toDouble() ?? 0,
        savedAt: DateTime.tryParse(timeStr) ?? DateTime.now(),
      );
    } catch (_) {
      return null;
    }
  }

  void deleteSave(int slot) {
    assert(slot >= 0 && slot < 3, 'Slot must be 0, 1, or 2');
    final box = Hive.box<String>(_gameSavesBox);
    box.delete('slot_$slot');
    box.delete('slot_${slot}_time');
  }

  // --- Hall of Fame ---

  void saveHallOfFame(List<PresidentRecord> records) {
    final box = Hive.box<String>(_hallOfFameBox);
    final json = jsonEncode(records.map((r) => r.toJson()).toList());
    box.put('records', json);
  }

  List<PresidentRecord> loadHallOfFame() {
    final box = Hive.box<String>(_hallOfFameBox);
    final json = box.get('records');
    if (json == null) return [];
    try {
      final list = jsonDecode(json) as List<dynamic>;
      return list.map((e) => PresidentRecord.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  // --- Achievements ---

  void saveAchievements(List<String> unlockedIds) {
    final box = Hive.box<String>(_achievementsBox);
    box.put('unlocked', jsonEncode(unlockedIds));
  }

  List<String> loadAchievements() {
    final box = Hive.box<String>(_achievementsBox);
    final json = box.get('unlocked');
    if (json == null) return [];
    try {
      final list = jsonDecode(json) as List<dynamic>;
      return list.cast<String>();
    } catch (_) {
      return [];
    }
  }

  // --- Settings ---

  void saveSettings(GameSettings settings) {
    final box = Hive.box<String>(_settingsBox);
    box.put('settings', jsonEncode(settings.toJson()));
  }

  GameSettings loadSettings() {
    final box = Hive.box<String>(_settingsBox);
    final json = box.get('settings');
    if (json == null) return GameSettings();
    try {
      return GameSettings.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      return GameSettings();
    }
  }
}

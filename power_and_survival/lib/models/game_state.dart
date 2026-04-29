import 'country_stats.dart';
import 'citizen_groups.dart';
import 'risk_scores.dart';
import 'character.dart';
import 'promise.dart';
import 'neighbor_country.dart';

class GameState {
  String presidentName;
  String countryName;
  String partyName;
  String ideology;
  String difficulty;
  String countryTrait;
  String inheritedCrisis;
  int currentMonth;
  int currentYear;
  int currentTerm;
  CountryStats stats;
  CitizenGroups citizenGroups;
  RiskScores riskScores;
  List<Character> characters;
  Map<String, double> budgetAllocation;
  List<String> activePolicyIds;
  List<Promise> activePromises;
  List<NeighborCountry> neighbors;
  List<String> eventHistory;
  List<String> decisionHistory;
  List<String> newsHistory;
  List<String> diaryEntries;
  List<String> earnedAchievements;
  List<String> activeCrisisChains;
  bool tutorialComplete;
  bool isGameOver;
  String? gameOverReason;
  String? currentLegacyEnding;

  GameState({
    this.presidentName = 'President',
    this.countryName = 'Republic',
    this.partyName = 'Unity Party',
    this.ideology = 'centrist',
    this.difficulty = 'normal',
    this.countryTrait = 'balanced',
    this.inheritedCrisis = 'none',
    this.currentMonth = 1,
    this.currentYear = 2025,
    this.currentTerm = 1,
    CountryStats? stats,
    CitizenGroups? citizenGroups,
    RiskScores? riskScores,
    List<Character>? characters,
    Map<String, double>? budgetAllocation,
    List<String>? activePolicyIds,
    List<Promise>? activePromises,
    List<NeighborCountry>? neighbors,
    List<String>? eventHistory,
    List<String>? decisionHistory,
    List<String>? newsHistory,
    List<String>? diaryEntries,
    List<String>? earnedAchievements,
    List<String>? activeCrisisChains,
    this.tutorialComplete = false,
    this.isGameOver = false,
    this.gameOverReason,
    this.currentLegacyEnding,
  })  : stats = stats ?? CountryStats(),
        citizenGroups = citizenGroups ?? CitizenGroups(),
        riskScores = riskScores ?? RiskScores(),
        characters = characters ?? [],
        budgetAllocation = budgetAllocation ?? {
          'health': 0.15, 'education': 0.15, 'military': 0.20,
          'infrastructure': 0.15, 'welfare': 0.10, 'security': 0.10,
          'debtPayment': 0.10, 'reserve': 0.05,
        },
        activePolicyIds = activePolicyIds ?? [],
        activePromises = activePromises ?? [],
        neighbors = neighbors ?? [],
        eventHistory = eventHistory ?? [],
        decisionHistory = decisionHistory ?? [],
        newsHistory = newsHistory ?? [],
        diaryEntries = diaryEntries ?? [],
        earnedAchievements = earnedAchievements ?? [],
        activeCrisisChains = activeCrisisChains ?? [];

  factory GameState.empty() => GameState();

  String get monthName {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[((currentMonth - 1) % 12)];
  }

  int get displayYear => currentYear + ((currentMonth - 1) ~/ 12);

  int get monthsInOffice => currentMonth;

  bool get isElectionMonth => currentMonth % 48 == 0 && currentMonth > 0;

  GameState copyWith({
    String? presidentName, String? countryName, String? partyName,
    String? ideology, String? difficulty, String? countryTrait,
    String? inheritedCrisis, int? currentMonth, int? currentYear,
    int? currentTerm, CountryStats? stats, CitizenGroups? citizenGroups,
    RiskScores? riskScores, List<Character>? characters,
    Map<String, double>? budgetAllocation, List<String>? activePolicyIds,
    List<Promise>? activePromises, List<NeighborCountry>? neighbors,
    List<String>? eventHistory, List<String>? decisionHistory,
    List<String>? newsHistory, List<String>? diaryEntries,
    List<String>? earnedAchievements, List<String>? activeCrisisChains,
    bool? tutorialComplete, bool? isGameOver, String? gameOverReason,
    String? currentLegacyEnding,
  }) {
    return GameState(
      presidentName: presidentName ?? this.presidentName,
      countryName: countryName ?? this.countryName,
      partyName: partyName ?? this.partyName,
      ideology: ideology ?? this.ideology,
      difficulty: difficulty ?? this.difficulty,
      countryTrait: countryTrait ?? this.countryTrait,
      inheritedCrisis: inheritedCrisis ?? this.inheritedCrisis,
      currentMonth: currentMonth ?? this.currentMonth,
      currentYear: currentYear ?? this.currentYear,
      currentTerm: currentTerm ?? this.currentTerm,
      stats: stats ?? this.stats,
      citizenGroups: citizenGroups ?? this.citizenGroups,
      riskScores: riskScores ?? this.riskScores,
      characters: characters ?? this.characters,
      budgetAllocation: budgetAllocation ?? this.budgetAllocation,
      activePolicyIds: activePolicyIds ?? this.activePolicyIds,
      activePromises: activePromises ?? this.activePromises,
      neighbors: neighbors ?? this.neighbors,
      eventHistory: eventHistory ?? this.eventHistory,
      decisionHistory: decisionHistory ?? this.decisionHistory,
      newsHistory: newsHistory ?? this.newsHistory,
      diaryEntries: diaryEntries ?? this.diaryEntries,
      earnedAchievements: earnedAchievements ?? this.earnedAchievements,
      activeCrisisChains: activeCrisisChains ?? this.activeCrisisChains,
      tutorialComplete: tutorialComplete ?? this.tutorialComplete,
      isGameOver: isGameOver ?? this.isGameOver,
      gameOverReason: gameOverReason ?? this.gameOverReason,
      currentLegacyEnding: currentLegacyEnding ?? this.currentLegacyEnding,
    );
  }

  Map<String, dynamic> toJson() => {
    'presidentName': presidentName, 'countryName': countryName,
    'partyName': partyName, 'ideology': ideology, 'difficulty': difficulty,
    'countryTrait': countryTrait, 'inheritedCrisis': inheritedCrisis,
    'currentMonth': currentMonth, 'currentYear': currentYear,
    'currentTerm': currentTerm, 'stats': stats.toJson(),
    'citizenGroups': citizenGroups.toJson(), 'riskScores': riskScores.toJson(),
    'characters': characters.map((c) => c.toJson()).toList(),
    'budgetAllocation': budgetAllocation,
    'activePolicyIds': activePolicyIds,
    'activePromises': activePromises.map((p) => p.toJson()).toList(),
    'neighbors': neighbors.map((n) => n.toJson()).toList(),
    'eventHistory': eventHistory, 'decisionHistory': decisionHistory,
    'newsHistory': newsHistory, 'diaryEntries': diaryEntries,
    'earnedAchievements': earnedAchievements,
    'activeCrisisChains': activeCrisisChains,
    'tutorialComplete': tutorialComplete, 'isGameOver': isGameOver,
    'gameOverReason': gameOverReason, 'currentLegacyEnding': currentLegacyEnding,
  };

  factory GameState.fromJson(Map<String, dynamic> json) => GameState(
    presidentName: json['presidentName'] as String? ?? 'President',
    countryName: json['countryName'] as String? ?? 'Republic',
    partyName: json['partyName'] as String? ?? 'Unity Party',
    ideology: json['ideology'] as String? ?? 'centrist',
    difficulty: json['difficulty'] as String? ?? 'normal',
    countryTrait: json['countryTrait'] as String? ?? 'balanced',
    inheritedCrisis: json['inheritedCrisis'] as String? ?? 'none',
    currentMonth: json['currentMonth'] as int? ?? 1,
    currentYear: json['currentYear'] as int? ?? 2025,
    currentTerm: json['currentTerm'] as int? ?? 1,
    stats: json['stats'] != null
        ? CountryStats.fromJson(json['stats'] as Map<String, dynamic>)
        : null,
    citizenGroups: json['citizenGroups'] != null
        ? CitizenGroups.fromJson(json['citizenGroups'] as Map<String, dynamic>)
        : null,
    riskScores: json['riskScores'] != null
        ? RiskScores.fromJson(json['riskScores'] as Map<String, dynamic>)
        : null,
    characters: (json['characters'] as List<dynamic>?)
        ?.map((e) => Character.fromJson(e as Map<String, dynamic>)).toList(),
    budgetAllocation: (json['budgetAllocation'] as Map<String, dynamic>?)
        ?.map((k, v) => MapEntry(k, (v as num).toDouble())),
    activePolicyIds: (json['activePolicyIds'] as List<dynamic>?)
        ?.map((e) => e as String).toList(),
    activePromises: (json['activePromises'] as List<dynamic>?)
        ?.map((e) => Promise.fromJson(e as Map<String, dynamic>)).toList(),
    neighbors: (json['neighbors'] as List<dynamic>?)
        ?.map((e) => NeighborCountry.fromJson(e as Map<String, dynamic>)).toList(),
    eventHistory: (json['eventHistory'] as List<dynamic>?)
        ?.map((e) => e as String).toList(),
    decisionHistory: (json['decisionHistory'] as List<dynamic>?)
        ?.map((e) => e as String).toList(),
    newsHistory: (json['newsHistory'] as List<dynamic>?)
        ?.map((e) => e as String).toList(),
    diaryEntries: (json['diaryEntries'] as List<dynamic>?)
        ?.map((e) => e as String).toList(),
    earnedAchievements: (json['earnedAchievements'] as List<dynamic>?)
        ?.map((e) => e as String).toList(),
    activeCrisisChains: (json['activeCrisisChains'] as List<dynamic>?)
        ?.map((e) => e as String).toList(),
    tutorialComplete: json['tutorialComplete'] as bool? ?? false,
    isGameOver: json['isGameOver'] as bool? ?? false,
    gameOverReason: json['gameOverReason'] as String?,
    currentLegacyEnding: json['currentLegacyEnding'] as String?,
  );
}

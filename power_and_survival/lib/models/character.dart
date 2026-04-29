class Character {
  final String id;
  final String name;
  final String role;
  double loyalty;
  double influence;
  double ambition;
  double corruption;
  double relationship;
  final String hiddenTrait;
  final String factionId;
  bool isActive;
  List<String> currentDemands;
  int monthsDisloyal;

  Character({
    required this.id,
    required this.name,
    required this.role,
    this.loyalty = 50,
    this.influence = 50,
    this.ambition = 50,
    this.corruption = 30,
    this.relationship = 50,
    this.hiddenTrait = 'pragmatist',
    this.factionId = 'neutral',
    this.isActive = true,
    List<String>? currentDemands,
    this.monthsDisloyal = 0,
  }) : currentDemands = currentDemands ?? [];

  Character copyWith({
    String? id, String? name, String? role,
    double? loyalty, double? influence, double? ambition,
    double? corruption, double? relationship,
    String? hiddenTrait, String? factionId, bool? isActive,
    List<String>? currentDemands, int? monthsDisloyal,
  }) {
    return Character(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      loyalty: loyalty ?? this.loyalty,
      influence: influence ?? this.influence,
      ambition: ambition ?? this.ambition,
      corruption: corruption ?? this.corruption,
      relationship: relationship ?? this.relationship,
      hiddenTrait: hiddenTrait ?? this.hiddenTrait,
      factionId: factionId ?? this.factionId,
      isActive: isActive ?? this.isActive,
      currentDemands: currentDemands ?? List.from(this.currentDemands),
      monthsDisloyal: monthsDisloyal ?? this.monthsDisloyal,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'role': role,
    'loyalty': loyalty, 'influence': influence, 'ambition': ambition,
    'corruption': corruption, 'relationship': relationship,
    'hiddenTrait': hiddenTrait, 'factionId': factionId,
    'isActive': isActive, 'currentDemands': currentDemands,
    'monthsDisloyal': monthsDisloyal,
  };

  factory Character.fromJson(Map<String, dynamic> json) => Character(
    id: json['id'] as String,
    name: json['name'] as String,
    role: json['role'] as String,
    loyalty: (json['loyalty'] as num?)?.toDouble() ?? 50,
    influence: (json['influence'] as num?)?.toDouble() ?? 50,
    ambition: (json['ambition'] as num?)?.toDouble() ?? 50,
    corruption: (json['corruption'] as num?)?.toDouble() ?? 30,
    relationship: (json['relationship'] as num?)?.toDouble() ?? 50,
    hiddenTrait: json['hiddenTrait'] as String? ?? 'pragmatist',
    factionId: json['factionId'] as String? ?? 'neutral',
    isActive: json['isActive'] as bool? ?? true,
    currentDemands: (json['currentDemands'] as List<dynamic>?)
        ?.map((e) => e as String).toList(),
    monthsDisloyal: json['monthsDisloyal'] as int? ?? 0,
  );
}

class PolicyModel {
  final String id;
  final String name;
  final String description;
  final double monthlyCost;
  bool isActive;
  final bool requiresParliament;
  bool parliamentApproved;
  final Map<String, double> monthlyEffects;
  final Map<String, double> sideEffects;
  final List<String> supportingFactions;
  final List<String> opposingFactions;

  PolicyModel({
    required this.id,
    required this.name,
    required this.description,
    this.monthlyCost = 0,
    this.isActive = false,
    this.requiresParliament = false,
    this.parliamentApproved = false,
    this.monthlyEffects = const {},
    this.sideEffects = const {},
    this.supportingFactions = const [],
    this.opposingFactions = const [],
  });

  PolicyModel copyWith({
    String? id, String? name, String? description, double? monthlyCost,
    bool? isActive, bool? requiresParliament, bool? parliamentApproved,
    Map<String, double>? monthlyEffects, Map<String, double>? sideEffects,
    List<String>? supportingFactions, List<String>? opposingFactions,
  }) {
    return PolicyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      monthlyCost: monthlyCost ?? this.monthlyCost,
      isActive: isActive ?? this.isActive,
      requiresParliament: requiresParliament ?? this.requiresParliament,
      parliamentApproved: parliamentApproved ?? this.parliamentApproved,
      monthlyEffects: monthlyEffects ?? Map.from(this.monthlyEffects),
      sideEffects: sideEffects ?? Map.from(this.sideEffects),
      supportingFactions: supportingFactions ?? List.from(this.supportingFactions),
      opposingFactions: opposingFactions ?? List.from(this.opposingFactions),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'description': description,
    'monthlyCost': monthlyCost, 'isActive': isActive,
    'requiresParliament': requiresParliament,
    'parliamentApproved': parliamentApproved,
    'monthlyEffects': monthlyEffects, 'sideEffects': sideEffects,
    'supportingFactions': supportingFactions,
    'opposingFactions': opposingFactions,
  };

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    monthlyCost: (json['monthlyCost'] as num?)?.toDouble() ?? 0,
    isActive: json['isActive'] as bool? ?? false,
    requiresParliament: json['requiresParliament'] as bool? ?? false,
    parliamentApproved: json['parliamentApproved'] as bool? ?? false,
    monthlyEffects: (json['monthlyEffects'] as Map<String, dynamic>?)
        ?.map((k, v) => MapEntry(k, (v as num).toDouble())) ?? {},
    sideEffects: (json['sideEffects'] as Map<String, dynamic>?)
        ?.map((k, v) => MapEntry(k, (v as num).toDouble())) ?? {},
    supportingFactions: (json['supportingFactions'] as List<dynamic>?)
        ?.map((e) => e as String).toList() ?? [],
    opposingFactions: (json['opposingFactions'] as List<dynamic>?)
        ?.map((e) => e as String).toList() ?? [],
  );
}

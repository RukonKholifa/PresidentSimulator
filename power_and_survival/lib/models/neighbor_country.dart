class NeighborCountry {
  final String id;
  final String name;
  final String governmentType;
  double relationScore;
  final String militaryStrength;
  final String economicStrength;

  NeighborCountry({
    required this.id,
    required this.name,
    required this.governmentType,
    this.relationScore = 50,
    this.militaryStrength = 'medium',
    this.economicStrength = 'medium',
  });

  NeighborCountry copyWith({
    String? id, String? name, String? governmentType,
    double? relationScore, String? militaryStrength, String? economicStrength,
  }) {
    return NeighborCountry(
      id: id ?? this.id,
      name: name ?? this.name,
      governmentType: governmentType ?? this.governmentType,
      relationScore: relationScore ?? this.relationScore,
      militaryStrength: militaryStrength ?? this.militaryStrength,
      economicStrength: economicStrength ?? this.economicStrength,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'governmentType': governmentType,
    'relationScore': relationScore, 'militaryStrength': militaryStrength,
    'economicStrength': economicStrength,
  };

  factory NeighborCountry.fromJson(Map<String, dynamic> json) => NeighborCountry(
    id: json['id'] as String,
    name: json['name'] as String,
    governmentType: json['governmentType'] as String,
    relationScore: (json['relationScore'] as num?)?.toDouble() ?? 50,
    militaryStrength: json['militaryStrength'] as String? ?? 'medium',
    economicStrength: json['economicStrength'] as String? ?? 'medium',
  );
}

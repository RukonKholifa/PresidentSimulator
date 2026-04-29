class Faction {
  final String id;
  final String name;
  final String description;
  double support;
  double influence;
  final List<String> priorities;
  final List<String> memberCharacterIds;

  Faction({
    required this.id,
    required this.name,
    required this.description,
    this.support = 50,
    this.influence = 50,
    this.priorities = const [],
    this.memberCharacterIds = const [],
  });

  Faction copyWith({
    String? id, String? name, String? description,
    double? support, double? influence,
    List<String>? priorities, List<String>? memberCharacterIds,
  }) {
    return Faction(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      support: support ?? this.support,
      influence: influence ?? this.influence,
      priorities: priorities ?? List.from(this.priorities),
      memberCharacterIds: memberCharacterIds ?? List.from(this.memberCharacterIds),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'description': description,
    'support': support, 'influence': influence,
    'priorities': priorities, 'memberCharacterIds': memberCharacterIds,
  };

  factory Faction.fromJson(Map<String, dynamic> json) => Faction(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    support: (json['support'] as num?)?.toDouble() ?? 50,
    influence: (json['influence'] as num?)?.toDouble() ?? 50,
    priorities: (json['priorities'] as List<dynamic>?)
        ?.map((e) => e as String).toList() ?? [],
    memberCharacterIds: (json['memberCharacterIds'] as List<dynamic>?)
        ?.map((e) => e as String).toList() ?? [],
  );
}

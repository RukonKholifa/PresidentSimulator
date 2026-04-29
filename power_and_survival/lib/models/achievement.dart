class Achievement {
  final String id;
  final String title;
  final String description;
  bool isUnlocked;
  final String condition;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    this.isUnlocked = false,
    required this.condition,
  });

  Achievement copyWith({
    String? id, String? title, String? description,
    bool? isUnlocked, String? condition,
  }) {
    return Achievement(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      condition: condition ?? this.condition,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id, 'title': title, 'description': description,
    'isUnlocked': isUnlocked, 'condition': condition,
  };

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    isUnlocked: json['isUnlocked'] as bool? ?? false,
    condition: json['condition'] as String,
  );
}

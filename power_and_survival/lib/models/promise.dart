class Promise {
  final String id;
  final String text;
  final String category;
  final int deadlineMonth;
  bool isKept;
  bool isBroken;
  final Map<String, double> keptEffects;
  final Map<String, double> brokenEffects;

  Promise({
    required this.id,
    required this.text,
    required this.category,
    required this.deadlineMonth,
    this.isKept = false,
    this.isBroken = false,
    this.keptEffects = const {},
    this.brokenEffects = const {},
  });

  Promise copyWith({
    String? id, String? text, String? category,
    int? deadlineMonth, bool? isKept, bool? isBroken,
    Map<String, double>? keptEffects, Map<String, double>? brokenEffects,
  }) {
    return Promise(
      id: id ?? this.id,
      text: text ?? this.text,
      category: category ?? this.category,
      deadlineMonth: deadlineMonth ?? this.deadlineMonth,
      isKept: isKept ?? this.isKept,
      isBroken: isBroken ?? this.isBroken,
      keptEffects: keptEffects ?? Map.from(this.keptEffects),
      brokenEffects: brokenEffects ?? Map.from(this.brokenEffects),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id, 'text': text, 'category': category,
    'deadlineMonth': deadlineMonth, 'isKept': isKept, 'isBroken': isBroken,
    'keptEffects': keptEffects, 'brokenEffects': brokenEffects,
  };

  factory Promise.fromJson(Map<String, dynamic> json) => Promise(
    id: json['id'] as String,
    text: json['text'] as String,
    category: json['category'] as String,
    deadlineMonth: json['deadlineMonth'] as int,
    isKept: json['isKept'] as bool? ?? false,
    isBroken: json['isBroken'] as bool? ?? false,
    keptEffects: (json['keptEffects'] as Map<String, dynamic>?)
        ?.map((k, v) => MapEntry(k, (v as num).toDouble())) ?? {},
    brokenEffects: (json['brokenEffects'] as Map<String, dynamic>?)
        ?.map((k, v) => MapEntry(k, (v as num).toDouble())) ?? {},
  );
}

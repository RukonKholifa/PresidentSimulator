class EventChoice {
  final String id;
  final String text;
  final Map<String, double> statEffects;
  final Map<String, double> characterEffects;
  final double? treasuryCost;
  final double? debtIncrease;
  final String? followUpEventId;
  final String? promiseId;
  final List<String> crisisChainTriggers;

  const EventChoice({
    required this.id,
    required this.text,
    this.statEffects = const {},
    this.characterEffects = const {},
    this.treasuryCost,
    this.debtIncrease,
    this.followUpEventId,
    this.promiseId,
    this.crisisChainTriggers = const [],
  });

  Map<String, dynamic> toJson() => {
    'id': id, 'text': text, 'statEffects': statEffects,
    'characterEffects': characterEffects, 'treasuryCost': treasuryCost,
    'debtIncrease': debtIncrease, 'followUpEventId': followUpEventId,
    'promiseId': promiseId, 'crisisChainTriggers': crisisChainTriggers,
  };

  factory EventChoice.fromJson(Map<String, dynamic> json) => EventChoice(
    id: json['id'] as String,
    text: json['text'] as String,
    statEffects: (json['statEffects'] as Map<String, dynamic>?)
        ?.map((k, v) => MapEntry(k, (v as num).toDouble())) ?? {},
    characterEffects: (json['characterEffects'] as Map<String, dynamic>?)
        ?.map((k, v) => MapEntry(k, (v as num).toDouble())) ?? {},
    treasuryCost: (json['treasuryCost'] as num?)?.toDouble(),
    debtIncrease: (json['debtIncrease'] as num?)?.toDouble(),
    followUpEventId: json['followUpEventId'] as String?,
    promiseId: json['promiseId'] as String?,
    crisisChainTriggers: (json['crisisChainTriggers'] as List<dynamic>?)
        ?.map((e) => e as String).toList() ?? [],
  );
}

class EventModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String? chainId;
  final int? chainStage;
  final String? nextChainEventId;
  final List<EventChoice> choices;
  final Map<String, double>? statTriggers;
  final bool isCharacterEvent;
  final String? characterId;

  const EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    this.chainId,
    this.chainStage,
    this.nextChainEventId,
    this.choices = const [],
    this.statTriggers,
    this.isCharacterEvent = false,
    this.characterId,
  });

  Map<String, dynamic> toJson() => {
    'id': id, 'title': title, 'description': description,
    'category': category, 'chainId': chainId, 'chainStage': chainStage,
    'nextChainEventId': nextChainEventId,
    'choices': choices.map((c) => c.toJson()).toList(),
    'statTriggers': statTriggers, 'isCharacterEvent': isCharacterEvent,
    'characterId': characterId,
  };

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    category: json['category'] as String,
    chainId: json['chainId'] as String?,
    chainStage: json['chainStage'] as int?,
    nextChainEventId: json['nextChainEventId'] as String?,
    choices: (json['choices'] as List<dynamic>?)
        ?.map((e) => EventChoice.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    statTriggers: (json['statTriggers'] as Map<String, dynamic>?)
        ?.map((k, v) => MapEntry(k, (v as num).toDouble())),
    isCharacterEvent: json['isCharacterEvent'] as bool? ?? false,
    characterId: json['characterId'] as String?,
  );
}

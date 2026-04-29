class CountryStats {
  double economy;
  double happiness;
  double military;
  double corruption;
  double health;
  double education;
  double crime;
  double internationalRelations;
  double stability;
  double mediaTrust;
  double oppositionPower;
  double approvalRating;
  double treasury;
  double debt;

  CountryStats({
    this.economy = 50,
    this.happiness = 50,
    this.military = 40,
    this.corruption = 30,
    this.health = 50,
    this.education = 50,
    this.crime = 30,
    this.internationalRelations = 50,
    this.stability = 50,
    this.mediaTrust = 50,
    this.oppositionPower = 40,
    this.approvalRating = 50,
    this.treasury = 500,
    this.debt = 0,
  });

  void clamp() {
    economy = economy.clamp(0, 100);
    happiness = happiness.clamp(0, 100);
    military = military.clamp(0, 100);
    corruption = corruption.clamp(0, 100);
    health = health.clamp(0, 100);
    education = education.clamp(0, 100);
    crime = crime.clamp(0, 100);
    internationalRelations = internationalRelations.clamp(0, 100);
    stability = stability.clamp(0, 100);
    mediaTrust = mediaTrust.clamp(0, 100);
    oppositionPower = oppositionPower.clamp(0, 100);
    approvalRating = approvalRating.clamp(0, 100);
  }

  void applyStat(String stat, double delta) {
    switch (stat) {
      case 'economy': economy += delta;
      case 'happiness': happiness += delta;
      case 'military': military += delta;
      case 'corruption': corruption += delta;
      case 'health': health += delta;
      case 'education': education += delta;
      case 'crime': crime += delta;
      case 'internationalRelations': internationalRelations += delta;
      case 'stability': stability += delta;
      case 'mediaTrust': mediaTrust += delta;
      case 'oppositionPower': oppositionPower += delta;
      case 'approvalRating': approvalRating += delta;
      case 'treasury': treasury += delta;
      case 'debt': debt += delta;
    }
    clamp();
  }

  double getStat(String stat) {
    return switch (stat) {
      'economy' => economy,
      'happiness' => happiness,
      'military' => military,
      'corruption' => corruption,
      'health' => health,
      'education' => education,
      'crime' => crime,
      'internationalRelations' => internationalRelations,
      'stability' => stability,
      'mediaTrust' => mediaTrust,
      'oppositionPower' => oppositionPower,
      'approvalRating' => approvalRating,
      'treasury' => treasury,
      'debt' => debt,
      _ => 0,
    };
  }

  CountryStats copyWith({
    double? economy, double? happiness, double? military, double? corruption,
    double? health, double? education, double? crime,
    double? internationalRelations, double? stability, double? mediaTrust,
    double? oppositionPower, double? approvalRating, double? treasury,
    double? debt,
  }) {
    return CountryStats(
      economy: economy ?? this.economy,
      happiness: happiness ?? this.happiness,
      military: military ?? this.military,
      corruption: corruption ?? this.corruption,
      health: health ?? this.health,
      education: education ?? this.education,
      crime: crime ?? this.crime,
      internationalRelations: internationalRelations ?? this.internationalRelations,
      stability: stability ?? this.stability,
      mediaTrust: mediaTrust ?? this.mediaTrust,
      oppositionPower: oppositionPower ?? this.oppositionPower,
      approvalRating: approvalRating ?? this.approvalRating,
      treasury: treasury ?? this.treasury,
      debt: debt ?? this.debt,
    );
  }

  Map<String, dynamic> toJson() => {
    'economy': economy, 'happiness': happiness, 'military': military,
    'corruption': corruption, 'health': health, 'education': education,
    'crime': crime, 'internationalRelations': internationalRelations,
    'stability': stability, 'mediaTrust': mediaTrust,
    'oppositionPower': oppositionPower, 'approvalRating': approvalRating,
    'treasury': treasury, 'debt': debt,
  };

  factory CountryStats.fromJson(Map<String, dynamic> json) => CountryStats(
    economy: (json['economy'] as num?)?.toDouble() ?? 50,
    happiness: (json['happiness'] as num?)?.toDouble() ?? 50,
    military: (json['military'] as num?)?.toDouble() ?? 40,
    corruption: (json['corruption'] as num?)?.toDouble() ?? 30,
    health: (json['health'] as num?)?.toDouble() ?? 50,
    education: (json['education'] as num?)?.toDouble() ?? 50,
    crime: (json['crime'] as num?)?.toDouble() ?? 30,
    internationalRelations: (json['internationalRelations'] as num?)?.toDouble() ?? 50,
    stability: (json['stability'] as num?)?.toDouble() ?? 50,
    mediaTrust: (json['mediaTrust'] as num?)?.toDouble() ?? 50,
    oppositionPower: (json['oppositionPower'] as num?)?.toDouble() ?? 40,
    approvalRating: (json['approvalRating'] as num?)?.toDouble() ?? 50,
    treasury: (json['treasury'] as num?)?.toDouble() ?? 500,
    debt: (json['debt'] as num?)?.toDouble() ?? 0,
  );

  factory CountryStats.fromMap(Map<String, double> map) => CountryStats(
    economy: map['economy'] ?? 50,
    happiness: map['happiness'] ?? 50,
    military: map['military'] ?? 40,
    corruption: map['corruption'] ?? 30,
    health: map['health'] ?? 50,
    education: map['education'] ?? 50,
    crime: map['crime'] ?? 30,
    internationalRelations: map['internationalRelations'] ?? 50,
    stability: map['stability'] ?? 50,
    mediaTrust: map['mediaTrust'] ?? 50,
    oppositionPower: map['oppositionPower'] ?? 40,
    approvalRating: map['approvalRating'] ?? 50,
    treasury: map['treasury'] ?? 500,
    debt: map['debt'] ?? 0,
  );
}

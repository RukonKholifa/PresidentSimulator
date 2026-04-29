class CitizenGroups {
  double students;
  double workers;
  double farmers;
  double businessOwners;
  double military;
  double media;
  double foreignAllies;
  double oppositionBase;
  double religiousCommunity;

  CitizenGroups({
    this.students = 50,
    this.workers = 50,
    this.farmers = 50,
    this.businessOwners = 50,
    this.military = 50,
    this.media = 50,
    this.foreignAllies = 50,
    this.oppositionBase = 30,
    this.religiousCommunity = 50,
  });

  void clamp() {
    students = students.clamp(0, 100);
    workers = workers.clamp(0, 100);
    farmers = farmers.clamp(0, 100);
    businessOwners = businessOwners.clamp(0, 100);
    military = military.clamp(0, 100);
    media = media.clamp(0, 100);
    foreignAllies = foreignAllies.clamp(0, 100);
    oppositionBase = oppositionBase.clamp(0, 100);
    religiousCommunity = religiousCommunity.clamp(0, 100);
  }

  double getGroup(String group) {
    return switch (group) {
      'students' => students,
      'workers' => workers,
      'farmers' => farmers,
      'businessOwners' => businessOwners,
      'military' => military,
      'media' => media,
      'foreignAllies' => foreignAllies,
      'oppositionBase' => oppositionBase,
      'religiousCommunity' => religiousCommunity,
      _ => 50,
    };
  }

  void applyGroup(String group, double delta) {
    switch (group) {
      case 'students': students += delta;
      case 'workers': workers += delta;
      case 'farmers': farmers += delta;
      case 'businessOwners': businessOwners += delta;
      case 'military': military += delta;
      case 'media': media += delta;
      case 'foreignAllies': foreignAllies += delta;
      case 'oppositionBase': oppositionBase += delta;
      case 'religiousCommunity': religiousCommunity += delta;
    }
    clamp();
  }

  CitizenGroups copyWith({
    double? students, double? workers, double? farmers,
    double? businessOwners, double? military, double? media,
    double? foreignAllies, double? oppositionBase, double? religiousCommunity,
  }) {
    return CitizenGroups(
      students: students ?? this.students,
      workers: workers ?? this.workers,
      farmers: farmers ?? this.farmers,
      businessOwners: businessOwners ?? this.businessOwners,
      military: military ?? this.military,
      media: media ?? this.media,
      foreignAllies: foreignAllies ?? this.foreignAllies,
      oppositionBase: oppositionBase ?? this.oppositionBase,
      religiousCommunity: religiousCommunity ?? this.religiousCommunity,
    );
  }

  Map<String, dynamic> toJson() => {
    'students': students, 'workers': workers, 'farmers': farmers,
    'businessOwners': businessOwners, 'military': military, 'media': media,
    'foreignAllies': foreignAllies, 'oppositionBase': oppositionBase,
    'religiousCommunity': religiousCommunity,
  };

  factory CitizenGroups.fromJson(Map<String, dynamic> json) => CitizenGroups(
    students: (json['students'] as num?)?.toDouble() ?? 50,
    workers: (json['workers'] as num?)?.toDouble() ?? 50,
    farmers: (json['farmers'] as num?)?.toDouble() ?? 50,
    businessOwners: (json['businessOwners'] as num?)?.toDouble() ?? 50,
    military: (json['military'] as num?)?.toDouble() ?? 50,
    media: (json['media'] as num?)?.toDouble() ?? 50,
    foreignAllies: (json['foreignAllies'] as num?)?.toDouble() ?? 50,
    oppositionBase: (json['oppositionBase'] as num?)?.toDouble() ?? 30,
    religiousCommunity: (json['religiousCommunity'] as num?)?.toDouble() ?? 50,
  );
}

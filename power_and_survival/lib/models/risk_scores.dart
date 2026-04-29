class RiskScores {
  double coup;
  double revolution;
  double bankruptcy;
  double scandal;
  double impeachment;
  double electionLoss;

  RiskScores({
    this.coup = 0,
    this.revolution = 0,
    this.bankruptcy = 0,
    this.scandal = 0,
    this.impeachment = 0,
    this.electionLoss = 0,
  });

  void clamp() {
    coup = coup.clamp(0, 100);
    revolution = revolution.clamp(0, 100);
    bankruptcy = bankruptcy.clamp(0, 100);
    scandal = scandal.clamp(0, 100);
    impeachment = impeachment.clamp(0, 100);
    electionLoss = electionLoss.clamp(0, 100);
  }

  double getRisk(String risk) {
    return switch (risk) {
      'coup' => coup,
      'revolution' => revolution,
      'bankruptcy' => bankruptcy,
      'scandal' => scandal,
      'impeachment' => impeachment,
      'electionLoss' => electionLoss,
      _ => 0,
    };
  }

  RiskScores copyWith({
    double? coup, double? revolution, double? bankruptcy,
    double? scandal, double? impeachment, double? electionLoss,
  }) {
    return RiskScores(
      coup: coup ?? this.coup,
      revolution: revolution ?? this.revolution,
      bankruptcy: bankruptcy ?? this.bankruptcy,
      scandal: scandal ?? this.scandal,
      impeachment: impeachment ?? this.impeachment,
      electionLoss: electionLoss ?? this.electionLoss,
    );
  }

  Map<String, dynamic> toJson() => {
    'coup': coup, 'revolution': revolution, 'bankruptcy': bankruptcy,
    'scandal': scandal, 'impeachment': impeachment, 'electionLoss': electionLoss,
  };

  factory RiskScores.fromJson(Map<String, dynamic> json) => RiskScores(
    coup: (json['coup'] as num?)?.toDouble() ?? 0,
    revolution: (json['revolution'] as num?)?.toDouble() ?? 0,
    bankruptcy: (json['bankruptcy'] as num?)?.toDouble() ?? 0,
    scandal: (json['scandal'] as num?)?.toDouble() ?? 0,
    impeachment: (json['impeachment'] as num?)?.toDouble() ?? 0,
    electionLoss: (json['electionLoss'] as num?)?.toDouble() ?? 0,
  );
}

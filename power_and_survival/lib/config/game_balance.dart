class GameBalance {
  GameBalance._();

  static const Map<String, Map<String, double>> startingStats = {
    'easy': {
      'economy': 55, 'happiness': 60, 'military': 45,
      'corruption': 25, 'health': 55, 'education': 55,
      'crime': 30, 'internationalRelations': 55, 'stability': 65,
      'mediaTrust': 55, 'oppositionPower': 30, 'approvalRating': 60,
      'treasury': 800, 'debt': 0,
    },
    'normal': {
      'economy': 45, 'happiness': 50, 'military': 40,
      'corruption': 35, 'health': 45, 'education': 45,
      'crime': 40, 'internationalRelations': 45, 'stability': 50,
      'mediaTrust': 45, 'oppositionPower': 40, 'approvalRating': 50,
      'treasury': 500, 'debt': 0,
    },
    'hard': {
      'economy': 35, 'happiness': 40, 'military': 35,
      'corruption': 45, 'health': 35, 'education': 35,
      'crime': 50, 'internationalRelations': 35, 'stability': 40,
      'mediaTrust': 35, 'oppositionPower': 50, 'approvalRating': 40,
      'treasury': 300, 'debt': 100,
    },
    'dictator': {
      'economy': 30, 'happiness': 35, 'military': 60,
      'corruption': 55, 'health': 30, 'education': 30,
      'crime': 55, 'internationalRelations': 25, 'stability': 45,
      'mediaTrust': 25, 'oppositionPower': 60, 'approvalRating': 35,
      'treasury': 400, 'debt': 150,
    },
  };

  static const Map<String, double> baseIncome = {
    'easy': 500, 'normal': 350, 'hard': 250, 'dictator': 200,
  };

  static const double debtInterestNormal = 0.005;
  static const double debtInterestHigh = 0.01;
  static const double debtInterestCritical = 0.02;

  static const double bankruptcyLimit = -1000;
  static const double collapseStability = 0;
  static const double collapseHappiness = 0;
  static const double maxCorruption = 100;
  static const double maxOpposition = 100;
  static const double coupRiskThreshold = 85;
  static const double revolutionRiskThreshold = 85;
  static const double impeachmentRiskThreshold = 80;

  static const double protestTriggerHappiness = 35;
  static const double riotTriggerHappiness = 25;
  static const double revolutionTriggerHappiness = 15;
  static const double scandalTriggerCorruption = 70;
  static const double imfTriggerDebt = 700;
  static const double coupWarningArmyLoyalty = 30;
  static const double studentMovementEducation = 35;
  static const double policeCrisisCrime = 70;

  static const double electionWeightApproval = 0.30;
  static const double electionWeightHappiness = 0.20;
  static const double electionWeightEconomy = 0.15;
  static const double electionWeightCorruption = 0.10;
  static const double electionWeightStability = 0.10;
  static const double electionWeightOpposition = 0.10;
  static const double electionWeightMedia = 0.05;
  static const double electionWinThreshold = 55;

  static const double coupWeightMilitary = 0.25;
  static const double coupWeightLoyalty = 0.35;
  static const double coupWeightAmbition = 0.15;
  static const double coupWeightApproval = 0.10;
  static const double coupWeightStability = 0.15;

  static const double healthDecayNoFunding = -1.0;
  static const double educationDecayNoFunding = -0.8;
  static const double militaryDecayNoFunding = -0.5;
  static const double infrastructureDecayNoFunding = -0.3;

  static const double economyToHappinessRate = 1.0;
  static const double corruptionToEconomyRate = -1.0;
  static const double corruptionToHappinessRate = -1.0;
  static const double crimeToHappinessRate = -1.0;
  static const double lowHealthToHappinessRate = -1.0;
  static const double highDebtToEconomyRate = -1.0;
}

class CharactersData {
  static const List<String> maleFirstNames = [
    'Alexander', 'Boris', 'Carlos', 'Dimitri', 'Eduardo',
    'Felix', 'Gabriel', 'Hassan', 'Ivan', 'Jorge',
    'Karim', 'Leon', 'Marco', 'Nikolai', 'Oscar',
    'Pavel', 'Rafael', 'Sergei', 'Tomas', 'Viktor',
    'Werner', 'Xavier', 'Yuri', 'Zoran', 'Andrei',
  ];

  static const List<String> femaleFirstNames = [
    'Amira', 'Beatriz', 'Carmen', 'Diana', 'Elena',
    'Fatima', 'Gabriela', 'Helena', 'Irene', 'Julia',
    'Katarina', 'Lucia', 'Maria', 'Natasha', 'Olga',
    'Patricia', 'Rosa', 'Sofia', 'Tatiana', 'Valentina',
    'Yara', 'Zara', 'Anastasia', 'Bianca', 'Claudia',
  ];

  static const List<String> lastNames = [
    'Volkov', 'Santos', 'Martinez', 'Petrova', 'Kim',
    'Hassan', 'Silva', 'Novak', 'Ivanov', 'Torres',
    'Chen', 'Popov', 'Gonzalez', 'Muller', 'Okafor',
    'Tanaka', 'Ali', 'Fernandez', 'Johansson', 'Kowalski',
    'Dubois', 'Schmidt', 'Romano', 'Vasquez', 'Nakamura',
  ];

  static const List<String> hiddenTraits = [
    'loyalist', 'traitor', 'opportunist', 'reformist', 'pragmatist',
  ];

  static const Map<String, Map<String, List<double>>> roleStatRanges = {
    'vice_president': {
      'loyalty': [40, 70], 'influence': [60, 80], 'ambition': [50, 80],
      'corruption': [20, 50], 'relationship': [40, 70],
    },
    'army_chief': {
      'loyalty': [30, 60], 'influence': [70, 90], 'ambition': [40, 70],
      'corruption': [20, 50], 'relationship': [30, 60],
    },
    'finance_minister': {
      'loyalty': [50, 70], 'influence': [50, 70], 'ambition': [30, 60],
      'corruption': [20, 60], 'relationship': [50, 70],
    },
    'intelligence_chief': {
      'loyalty': [40, 60], 'influence': [60, 80], 'ambition': [40, 70],
      'corruption': [30, 60], 'relationship': [30, 60],
    },
    'interior_minister': {
      'loyalty': [50, 70], 'influence': [40, 60], 'ambition': [30, 50],
      'corruption': [20, 50], 'relationship': [50, 70],
    },
    'foreign_minister': {
      'loyalty': [50, 70], 'influence': [40, 70], 'ambition': [30, 50],
      'corruption': [10, 40], 'relationship': [50, 70],
    },
    'media_advisor': {
      'loyalty': [50, 80], 'influence': [40, 60], 'ambition': [20, 50],
      'corruption': [10, 40], 'relationship': [50, 80],
    },
    'party_leader': {
      'loyalty': [40, 70], 'influence': [50, 70], 'ambition': [40, 70],
      'corruption': [20, 50], 'relationship': [40, 70],
    },
    'business_tycoon': {
      'loyalty': [20, 50], 'influence': [60, 90], 'ambition': [60, 90],
      'corruption': [40, 70], 'relationship': [30, 60],
    },
    'student_leader': {
      'loyalty': [20, 50], 'influence': [30, 60], 'ambition': [50, 80],
      'corruption': [5, 20], 'relationship': [20, 50],
    },
  };

  static const Map<String, List<String>> roleAdviceTemplates = {
    'vice_president': [
      'I think we should take a balanced approach here, Mr. President.',
      'The political implications are significant. Let\'s tread carefully.',
      'Our party\'s unity depends on how we handle this situation.',
    ],
    'army_chief': [
      'We need to show strength. Weakness invites aggression.',
      'The military stands ready, but we need clear orders.',
      'Security must be our top priority in this situation.',
    ],
    'finance_minister': [
      'The numbers don\'t lie — we need fiscal responsibility.',
      'This will cost us dearly. Are we prepared for the economic impact?',
      'I recommend a cost-benefit analysis before proceeding.',
    ],
    'intelligence_chief': [
      'My sources indicate there\'s more to this than meets the eye.',
      'We should verify this intelligence before taking action.',
      'I\'ll have my people look into the background of this situation.',
    ],
    'interior_minister': [
      'Public order must be maintained at all costs.',
      'The police are prepared to handle this situation.',
      'We need to consider the impact on domestic security.',
    ],
    'foreign_minister': [
      'Our international reputation is at stake here.',
      'I recommend consulting with our allies before deciding.',
      'This could affect our standing in the international community.',
    ],
    'media_advisor': [
      'The media coverage of this will be intense. We need a strategy.',
      'Let me prepare a statement that frames this positively.',
      'Public perception is everything — we need to control the narrative.',
    ],
    'party_leader': [
      'The party rank-and-file are watching closely.',
      'We need to maintain party discipline on this issue.',
      'Our base expects us to stay true to our principles.',
    ],
    'business_tycoon': [
      'The business community needs certainty and stability.',
      'This is an opportunity for economic growth if handled correctly.',
      'Investment will flee if we make the wrong decision here.',
    ],
    'student_leader': [
      'The youth of this country demand real change, not promises.',
      'Education and jobs — that\'s what young people care about.',
      'We won\'t stay silent while the future is being decided without us.',
    ],
  };

  static const List<String> characterRoles = [
    'vice_president', 'army_chief', 'finance_minister',
    'intelligence_chief', 'interior_minister', 'foreign_minister',
    'media_advisor', 'party_leader', 'business_tycoon', 'student_leader',
  ];

  static const Map<String, String> roleDisplayNames = {
    'vice_president': 'Vice President',
    'army_chief': 'Army Chief',
    'finance_minister': 'Finance Minister',
    'intelligence_chief': 'Intelligence Chief',
    'interior_minister': 'Interior Minister',
    'foreign_minister': 'Foreign Minister',
    'media_advisor': 'Media Advisor',
    'party_leader': 'Party Leader',
    'business_tycoon': 'Business Tycoon',
    'student_leader': 'Student Leader',
  };

  static const Map<String, String> roleFactions = {
    'vice_president': 'government',
    'army_chief': 'military',
    'finance_minister': 'government',
    'intelligence_chief': 'security',
    'interior_minister': 'government',
    'foreign_minister': 'government',
    'media_advisor': 'media',
    'party_leader': 'party',
    'business_tycoon': 'business',
    'student_leader': 'civil_society',
  };
}

class CountryTraitsData {
  static const Map<String, Map<String, dynamic>> allTraits = {
    'balanced': {
      'name': 'Balanced Republic',
      'description': 'A well-rounded nation with no extreme strengths or weaknesses.',
      'statModifiers': <String, double>{},
    },
    'oil_rich': {
      'name': 'Oil-Rich State',
      'description': 'Abundant natural resources provide wealth but attract corruption and foreign interference.',
      'statModifiers': {
        'economy': 10.0, 'treasury': 200.0, 'corruption': 10.0,
        'internationalRelations': -5.0,
      },
    },
    'military_tradition': {
      'name': 'Military Tradition',
      'description': 'A nation with a proud military history. The army has great influence in politics.',
      'statModifiers': {
        'military': 15.0, 'stability': 5.0, 'happiness': -5.0,
        'mediaTrust': -5.0,
      },
    },
    'young_democracy': {
      'name': 'Young Democracy',
      'description': 'A recently democratized nation. Institutions are fragile but hope is high.',
      'statModifiers': {
        'happiness': 10.0, 'stability': -10.0, 'mediaTrust': 10.0,
        'oppositionPower': 10.0,
      },
    },
    'island_nation': {
      'name': 'Island Nation',
      'description': 'Geographic isolation provides security but limits trade opportunities.',
      'statModifiers': {
        'stability': 10.0, 'crime': -5.0, 'economy': -5.0,
        'internationalRelations': -5.0,
      },
    },
    'agricultural_heartland': {
      'name': 'Agricultural Heartland',
      'description': 'The economy depends heavily on farming. Rural communities dominate politics.',
      'statModifiers': {
        'health': 5.0, 'education': -5.0, 'economy': -5.0,
        'happiness': 5.0,
      },
    },
    'tech_hub': {
      'name': 'Emerging Tech Hub',
      'description': 'A young, educated population driving a technology boom.',
      'statModifiers': {
        'education': 10.0, 'economy': 5.0, 'happiness': 5.0,
        'military': -5.0,
      },
    },
    'post_conflict': {
      'name': 'Post-Conflict Nation',
      'description': 'Recovering from civil war. Deep scars remain but the people yearn for peace.',
      'statModifiers': {
        'stability': -15.0, 'military': 10.0, 'happiness': -10.0,
        'crime': 10.0, 'health': -10.0,
      },
    },
  };

  static Map<String, dynamic>? getTraitById(String id) => allTraits[id];

  static List<String> get traitIds => allTraits.keys.toList();

  static Map<String, double> getStatModifiers(String traitId) {
    final trait = allTraits[traitId];
    if (trait == null) return {};
    final mods = trait['statModifiers'];
    if (mods is Map<String, double>) return mods;
    if (mods is Map) return mods.map((k, v) => MapEntry(k.toString(), (v as num).toDouble()));
    return {};
  }
}

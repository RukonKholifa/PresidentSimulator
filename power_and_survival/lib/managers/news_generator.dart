import 'dart:math';
import '../models/game_state.dart';

class NewsGenerator {
  final Random _random = Random();

  List<String> generateMonthlyNews(GameState state) {
    final news = <String>[];

    news.add(_getEconomyHeadline(state));
    news.add(_getApprovalHeadline(state));

    if (state.stats.corruption > 60) {
      news.add(_getCorruptionHeadline(state));
    }
    if (state.stats.crime > 50) {
      news.add(_getCrimeHeadline(state));
    }
    if (state.stats.health < 40) {
      news.add(_getHealthHeadline(state));
    }
    if (state.stats.oppositionPower > 60) {
      news.add(_getOppositionHeadline(state));
    }

    news.add(_getRandomFlavorHeadline(state));

    return news;
  }

  String _getEconomyHeadline(GameState state) {
    if (state.stats.economy > 70) {
      return _pick([
        'Economic boom continues as GDP growth exceeds expectations',
        'Foreign investors flock to ${state.countryName} as economy soars',
        'Unemployment hits record low — workers in high demand',
      ]);
    } else if (state.stats.economy < 30) {
      return _pick([
        'Economic crisis deepens as businesses close their doors',
        'Record unemployment — citizens struggle to find work',
        'Currency continues to fall against major trading partners',
      ]);
    }
    return _pick([
      'Economy shows mixed signals — analysts divided on outlook',
      'Moderate economic growth continues — experts cautiously optimistic',
      'Trade balance stable as imports and exports remain steady',
    ]);
  }

  String _getApprovalHeadline(GameState state) {
    if (state.stats.approvalRating > 70) {
      return _pick([
        'President ${state.presidentName} enjoys record approval ratings',
        'Citizens express strong confidence in presidential leadership',
        'Poll: Majority of voters would reelect ${state.presidentName}',
      ]);
    } else if (state.stats.approvalRating < 30) {
      return _pick([
        'President ${state.presidentName}\'s approval hits new low',
        'Growing discontent: citizens demand change in leadership',
        'Opposition leaders call for ${state.presidentName} to resign',
      ]);
    }
    return _pick([
      'Public opinion split on presidential performance',
      'President maintains moderate approval as term continues',
      'Voters express mixed feelings about current administration',
    ]);
  }

  String _getCorruptionHeadline(GameState state) {
    return _pick([
      'Anti-corruption watchdog warns of endemic graft in government',
      'Leaked documents suggest widespread bribery among officials',
      'International transparency report ranks ${state.countryName} poorly',
      'Citizens report paying bribes for basic government services',
    ]);
  }

  String _getCrimeHeadline(GameState state) {
    return _pick([
      'Crime wave grips major cities — police overwhelmed',
      'Home burglaries up 40% — residents demand action',
      'Gang violence claims lives in capital neighborhoods',
      'Citizens form neighborhood watch groups as crime rises',
    ]);
  }

  String _getHealthHeadline(GameState state) {
    return _pick([
      'Hospitals report critical shortage of medical supplies',
      'Public health crisis: disease outbreaks in crowded areas',
      'Doctors threaten to strike over unpaid wages and poor conditions',
      'Child mortality rate rises for third consecutive quarter',
    ]);
  }

  String _getOppositionHeadline(GameState state) {
    return _pick([
      'Opposition party gains momentum in latest polls',
      'Opposition leader announces "shadow cabinet" lineup',
      'Major rally draws thousands to opposition cause',
      'Opposition parties form united front against government',
    ]);
  }

  String _getRandomFlavorHeadline(GameState state) {
    return _pick([
      'National soccer team qualifies for international tournament',
      'New cultural center opens in the capital to great fanfare',
      'Local tech startup raises record funding from investors',
      'Famous author from ${state.countryName} wins international prize',
      'Tourism numbers show steady increase from previous year',
      'Weather forecast: seasonal changes expected this month',
      'University of ${state.countryName} climbs in global rankings',
      'Local musician\'s album tops international charts',
      'National zoo welcomes rare endangered species',
      'Bridge construction project reaches major milestone',
    ]);
  }

  String _pick(List<String> options) {
    return options[_random.nextInt(options.length)];
  }
}

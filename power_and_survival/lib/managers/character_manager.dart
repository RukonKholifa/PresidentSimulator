import 'dart:math';
import '../models/game_state.dart';
import '../models/character.dart';
import '../data/characters_data.dart';
import '../utils/random_utils.dart';

class CharacterManager {
  List<Character> generateStartingCharacters() {
    final characters = <Character>[];
    final usedNames = <String>{};

    for (final role in CharactersData.characterRoles) {
      final name = _generateUniqueName(usedNames);
      usedNames.add(name);

      final ranges = CharactersData.roleStatRanges[role]!;
      final hiddenTrait = RandomUtils.pick(CharactersData.hiddenTraits);
      final faction = CharactersData.roleFactions[role] ?? 'neutral';

      characters.add(Character(
        id: role,
        name: name,
        role: role,
        loyalty: RandomUtils.range(ranges['loyalty']![0], ranges['loyalty']![1]),
        influence: RandomUtils.range(ranges['influence']![0], ranges['influence']![1]),
        ambition: RandomUtils.range(ranges['ambition']![0], ranges['ambition']![1]),
        corruption: RandomUtils.range(ranges['corruption']![0], ranges['corruption']![1]),
        relationship: RandomUtils.range(ranges['relationship']![0], ranges['relationship']![1]),
        hiddenTrait: hiddenTrait,
        factionId: faction,
      ));
    }

    return characters;
  }

  String _generateUniqueName(Set<String> usedNames) {
    final allFirst = [...CharactersData.maleFirstNames, ...CharactersData.femaleFirstNames];
    String name;
    do {
      final first = RandomUtils.pick(allFirst);
      final last = RandomUtils.pick(CharactersData.lastNames);
      name = '$first $last';
    } while (usedNames.contains(name));
    return name;
  }

  void updateCharacterMonthly(GameState state) {
    for (final character in state.characters) {
      if (!character.isActive) continue;

      switch (character.hiddenTrait) {
        case 'loyalist':
          character.loyalty = (character.loyalty + 0.5).clamp(0, 100);
        case 'traitor':
          character.loyalty = (character.loyalty - 0.5).clamp(0, 100);
          character.ambition = (character.ambition + 0.3).clamp(0, 100);
        case 'opportunist':
          if (state.stats.approvalRating > 60) {
            character.loyalty = (character.loyalty + 0.3).clamp(0, 100);
          } else {
            character.loyalty = (character.loyalty - 0.3).clamp(0, 100);
          }
        case 'reformist':
          if (state.stats.corruption < 30) {
            character.loyalty = (character.loyalty + 0.5).clamp(0, 100);
          } else {
            character.loyalty = (character.loyalty - 0.3).clamp(0, 100);
          }
        case 'pragmatist':
          break;
      }

      if (character.loyalty < 30) {
        character.monthsDisloyal++;
      } else {
        character.monthsDisloyal = 0;
      }
    }
  }

  List<Character> getDisloyalCharacters(GameState state) {
    return state.characters.where((c) => c.isActive && c.loyalty < 30).toList();
  }

  List<Character> getAmbitionCharacters(GameState state) {
    return state.characters.where((c) => c.isActive && c.ambition > 70).toList();
  }

  String getAdvisorComment(Character character) {
    final templates = CharactersData.roleAdviceTemplates[character.role];
    if (templates == null || templates.isEmpty) {
      return 'I have no comment at this time.';
    }
    return templates[Random().nextInt(templates.length)];
  }

  void dismissCharacter(GameState state, String characterId) {
    final character = state.characters.firstWhere(
      (c) => c.id == characterId,
      orElse: () => throw ArgumentError('Character not found'),
    );
    character.isActive = false;
    state.diaryEntries.add(
      'Month ${state.currentMonth}: Dismissed ${CharactersData.roleDisplayNames[character.role] ?? character.role} ${character.name}',
    );
  }

  Character generateReplacementCharacter(String role, Set<String> usedNames) {
    final name = _generateUniqueName(usedNames);
    final ranges = CharactersData.roleStatRanges[role] ??
        {'loyalty': [40.0, 70.0], 'influence': [30.0, 60.0], 'ambition': [30.0, 60.0], 'corruption': [20.0, 50.0], 'relationship': [40.0, 60.0]};
    final hiddenTrait = RandomUtils.pick(CharactersData.hiddenTraits);
    final faction = CharactersData.roleFactions[role] ?? 'neutral';

    return Character(
      id: role,
      name: name,
      role: role,
      loyalty: RandomUtils.range(ranges['loyalty']![0], ranges['loyalty']![1]),
      influence: RandomUtils.range(ranges['influence']![0], ranges['influence']![1]),
      ambition: RandomUtils.range(ranges['ambition']![0], ranges['ambition']![1]),
      corruption: RandomUtils.range(ranges['corruption']![0], ranges['corruption']![1]),
      relationship: RandomUtils.range(ranges['relationship']![0], ranges['relationship']![1]),
      hiddenTrait: hiddenTrait,
      factionId: faction,
    );
  }

  String getRoleDisplayName(String role) {
    return CharactersData.roleDisplayNames[role] ?? role;
  }
}

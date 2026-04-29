import '../models/game_state.dart';
import '../models/faction.dart';

class FactionManager {
  static List<Faction> createDefaultFactions() {
    return [
      Faction(
        id: 'government',
        name: 'Government Coalition',
        description: 'Your party and allied politicians who support your agenda.',
        support: 60,
        influence: 70,
        priorities: ['stability', 'economy', 'approvalRating'],
      ),
      Faction(
        id: 'military',
        name: 'Military Establishment',
        description: 'The armed forces and defense establishment.',
        support: 50,
        influence: 80,
        priorities: ['military', 'stability', 'security'],
      ),
      Faction(
        id: 'business',
        name: 'Business Elite',
        description: 'Wealthy industrialists and corporate leaders.',
        support: 50,
        influence: 70,
        priorities: ['economy', 'deregulation', 'trade'],
      ),
      Faction(
        id: 'civil_society',
        name: 'Civil Society',
        description: 'NGOs, student organizations, and activist groups.',
        support: 40,
        influence: 40,
        priorities: ['education', 'health', 'mediaTrust'],
      ),
      Faction(
        id: 'media',
        name: 'Media & Press',
        description: 'Journalists, broadcasters, and media owners.',
        support: 50,
        influence: 60,
        priorities: ['mediaTrust', 'corruption', 'transparency'],
      ),
      Faction(
        id: 'opposition',
        name: 'Political Opposition',
        description: 'Rival parties seeking to replace your government.',
        support: 40,
        influence: 50,
        priorities: ['oppositionPower', 'elections', 'reform'],
      ),
      Faction(
        id: 'security',
        name: 'Security Services',
        description: 'Intelligence agencies and internal security forces.',
        support: 50,
        influence: 60,
        priorities: ['stability', 'crime', 'security'],
      ),
      Faction(
        id: 'party',
        name: 'Your Party',
        description: 'Members and supporters of your political party.',
        support: 60,
        influence: 50,
        priorities: ['approvalRating', 'stability', 'partyUnity'],
      ),
    ];
  }

  void updateFactionSupport(GameState state) {
    for (final character in state.characters) {
      if (!character.isActive) continue;
      if (character.loyalty > 70) {
        _adjustFactionSupport(state, character.factionId, 0.5);
      } else if (character.loyalty < 30) {
        _adjustFactionSupport(state, character.factionId, -0.5);
      }
    }
  }

  void _adjustFactionSupport(GameState state, String factionId, double delta) {
    // Faction support tracked through citizen groups
    switch (factionId) {
      case 'military':
        state.citizenGroups.military = (state.citizenGroups.military + delta).clamp(0, 100);
      case 'business':
        state.citizenGroups.businessOwners = (state.citizenGroups.businessOwners + delta).clamp(0, 100);
      case 'civil_society':
        state.citizenGroups.students = (state.citizenGroups.students + delta).clamp(0, 100);
      case 'media':
        state.citizenGroups.media = (state.citizenGroups.media + delta).clamp(0, 100);
    }
  }
}

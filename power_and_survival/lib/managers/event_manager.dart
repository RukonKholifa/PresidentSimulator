import 'dart:math';
import '../models/game_state.dart';
import '../models/event_model.dart';
import '../data/events_data.dart';
import '../config/game_balance.dart';

class EventManager {
  final Random _random = Random();

  EventModel? getRandomEvent(GameState state) {
    final triggered = _getTriggeredEvents(state);
    if (triggered.isNotEmpty) {
      return triggered[_random.nextInt(triggered.length)];
    }

    final chainEvent = _getChainEvent(state);
    if (chainEvent != null) return chainEvent;

    final available = _getAvailableEvents(state);
    if (available.isEmpty) return null;
    return available[_random.nextInt(available.length)];
  }

  List<EventModel> _getTriggeredEvents(GameState state) {
    final triggered = <EventModel>[];

    for (final event in EventsData.allEvents) {
      if (state.eventHistory.contains(event.id)) continue;
      if (event.statTriggers == null) continue;

      bool shouldTrigger = true;
      for (final entry in event.statTriggers!.entries) {
        final currentValue = state.stats.getStat(entry.key);
        if (currentValue < entry.value) {
          shouldTrigger = false;
          break;
        }
      }
      if (shouldTrigger) triggered.add(event);
    }

    if (state.stats.happiness < GameBalance.protestTriggerHappiness &&
        !state.eventHistory.contains('protest_stage_1') &&
        !state.activeCrisisChains.contains('protest_chain')) {
      final protestEvent = EventsData.getEventById('protest_stage_1');
      if (protestEvent != null) triggered.add(protestEvent);
    }

    if (state.stats.corruption > GameBalance.scandalTriggerCorruption &&
        !state.eventHistory.contains('corruption_scandal_breaks')) {
      final scandalEvent = EventsData.getEventById('corruption_scandal_breaks');
      if (scandalEvent != null) triggered.add(scandalEvent);
    }

    return triggered;
  }

  EventModel? _getChainEvent(GameState state) {
    for (final chainId in state.activeCrisisChains) {
      final chainEvents = EventsData.getChainEvents(chainId);
      for (final event in chainEvents) {
        if (!state.eventHistory.contains(event.id)) {
          return event;
        }
      }
    }
    return null;
  }

  List<EventModel> _getAvailableEvents(GameState state) {
    return EventsData.allEvents.where((event) {
      if (state.eventHistory.contains(event.id)) return false;
      if (event.chainId != null && event.chainStage != null && event.chainStage! > 1) {
        return false;
      }
      return true;
    }).toList();
  }

  void applyChoice(GameState state, EventModel event, EventChoice choice) {
    for (final entry in choice.statEffects.entries) {
      state.stats.applyStat(entry.key, entry.value);
    }

    if (choice.treasuryCost != null) {
      state.stats.treasury -= choice.treasuryCost!;
    }
    if (choice.debtIncrease != null) {
      state.stats.debt += choice.debtIncrease!;
    }

    for (final entry in choice.characterEffects.entries) {
      final character = state.characters.where((c) => c.role == entry.key || c.id == entry.key).toList();
      if (character.isNotEmpty) {
        character.first.loyalty = (character.first.loyalty + entry.value).clamp(0, 100);
        character.first.relationship = (character.first.relationship + entry.value * 0.5).clamp(0, 100);
      }
    }

    if (choice.followUpEventId != null) {
      if (event.chainId != null && !state.activeCrisisChains.contains(event.chainId)) {
        state.activeCrisisChains.add(event.chainId!);
      }
    }

    for (final chain in choice.crisisChainTriggers) {
      if (!state.activeCrisisChains.contains(chain)) {
        state.activeCrisisChains.add(chain);
      }
    }

    state.eventHistory.add(event.id);
    state.decisionHistory.add('${event.id}:${choice.id}');

    final diaryEntry = 'Month ${state.currentMonth}: ${event.title} — Chose: ${choice.text.substring(0, min(80, choice.text.length))}...';
    state.diaryEntries.add(diaryEntry);
  }

  bool shouldTriggerEvent(GameState state) {
    if (state.activeCrisisChains.isNotEmpty) return true;
    return _random.nextDouble() < 0.7;
  }
}

import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../models/event_model.dart';
import '../config/routes.dart';
import '../managers/simulation_engine.dart';
import '../widgets/event_card_widget.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final state = args?['state'] as GameState?;
    final event = args?['event'] as EventModel?;

    if (state == null || event == null) {
      return const Scaffold(body: Center(child: Text('Error: No event data')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Event')),
      body: SingleChildScrollView(
        child: EventCardWidget(
          event: event,
          onChoiceSelected: (choice) {
            final engine = SimulationEngine();
            engine.applyEventChoice(state, event, choice);

            if (state.isGameOver) {
              state.currentLegacyEnding = engine.determineLegacyEnding(state);
              Navigator.pushReplacementNamed(context, AppRoutes.gameOver, arguments: state);
            } else if (choice.followUpEventId != null) {
              final followUp = engine.eventManager.getRandomEvent(state);
              if (followUp != null) {
                Navigator.pushReplacementNamed(context, AppRoutes.event, arguments: {'state': state, 'event': followUp});
              } else {
                Navigator.pushReplacementNamed(context, AppRoutes.monthlyReport, arguments: state);
              }
            } else {
              Navigator.pushReplacementNamed(context, AppRoutes.monthlyReport, arguments: state);
            }
          },
        ),
      ),
    );
  }
}

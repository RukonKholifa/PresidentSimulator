import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';
import '../widgets/action_button_widget.dart';

class ActionSelectScreen extends StatelessWidget {
  const ActionSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = ModalRoute.of(context)?.settings.arguments as GameState?;

    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.actions)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.3,
          children: [
            ActionButtonWidget(
              label: StringsEn.travelCard,
              icon: Icons.flight,
              onTap: () => Navigator.pushNamed(context, AppRoutes.travelCard, arguments: state),
            ),
            ActionButtonWidget(
              label: StringsEn.pressMeeting,
              icon: Icons.mic,
              onTap: () => Navigator.pushNamed(context, AppRoutes.pressMeeting, arguments: state),
            ),
            ActionButtonWidget(
              label: StringsEn.cabinetMeeting,
              icon: Icons.groups,
              onTap: () => Navigator.pushNamed(context, AppRoutes.cabinetMeeting, arguments: state),
            ),
            ActionButtonWidget(
              label: StringsEn.manageBudget,
              icon: Icons.pie_chart,
              onTap: () => Navigator.pushNamed(context, AppRoutes.budget, arguments: state),
            ),
            ActionButtonWidget(
              label: StringsEn.managePolicies,
              icon: Icons.policy,
              onTap: () => Navigator.pushNamed(context, AppRoutes.policy, arguments: state),
              color: AppTheme.info,
            ),
            ActionButtonWidget(
              label: StringsEn.viewPowerCircle,
              icon: Icons.people,
              onTap: () => Navigator.pushNamed(context, AppRoutes.powerCircle, arguments: state),
              color: AppTheme.warning,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/main_menu_screen.dart';
import '../screens/new_game_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/event_screen.dart';
import '../screens/budget_screen.dart';
import '../screens/policy_screen.dart';
import '../screens/power_circle_screen.dart';
import '../screens/promise_tracker_screen.dart';
import '../screens/world_map_screen.dart';
import '../screens/monthly_report_screen.dart';
import '../screens/election_screen.dart';
import '../screens/game_over_screen.dart';
import '../screens/hall_of_fame_screen.dart';
import '../screens/achievements_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/diary_screen.dart';
import '../screens/action_select_screen.dart';
import '../screens/travel_card_screen.dart';
import '../screens/press_meeting_screen.dart';
import '../screens/cabinet_meeting_screen.dart';
import '../screens/character_detail_screen.dart';
import '../screens/parliament_vote_screen.dart';
import '../screens/legacy_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String mainMenu = '/main_menu';
  static const String newGame = '/new_game';
  static const String dashboard = '/dashboard';
  static const String event = '/event';
  static const String actionSelect = '/action_select';
  static const String travelCard = '/travel_card';
  static const String pressMeeting = '/press_meeting';
  static const String cabinetMeeting = '/cabinet_meeting';
  static const String budget = '/budget';
  static const String policy = '/policy';
  static const String powerCircle = '/power_circle';
  static const String characterDetail = '/character_detail';
  static const String promiseTracker = '/promise_tracker';
  static const String worldMap = '/world_map';
  static const String monthlyReport = '/monthly_report';
  static const String parliamentVote = '/parliament_vote';
  static const String election = '/election';
  static const String legacy = '/legacy';
  static const String gameOver = '/game_over';
  static const String hallOfFame = '/hall_of_fame';
  static const String achievements = '/achievements';
  static const String settings = '/settings';
  static const String diary = '/diary';

  static Map<String, WidgetBuilder> get routes => {
    splash: (_) => const SplashScreen(),
    mainMenu: (_) => const MainMenuScreen(),
    newGame: (_) => const NewGameScreen(),
    dashboard: (_) => const DashboardScreen(),
    event: (_) => const EventScreen(),
    actionSelect: (_) => const ActionSelectScreen(),
    travelCard: (_) => const TravelCardScreen(),
    pressMeeting: (_) => const PressMeetingScreen(),
    cabinetMeeting: (_) => const CabinetMeetingScreen(),
    budget: (_) => const BudgetScreen(),
    policy: (_) => const PolicyScreen(),
    powerCircle: (_) => const PowerCircleScreen(),
    characterDetail: (_) => const CharacterDetailScreen(),
    promiseTracker: (_) => const PromiseTrackerScreen(),
    worldMap: (_) => const WorldMapScreen(),
    monthlyReport: (_) => const MonthlyReportScreen(),
    parliamentVote: (_) => const ParliamentVoteScreen(),
    election: (_) => const ElectionScreen(),
    legacy: (_) => const LegacyScreen(),
    gameOver: (_) => const GameOverScreen(),
    hallOfFame: (_) => const HallOfFameScreen(),
    achievements: (_) => const AchievementsScreen(),
    settings: (_) => const SettingsScreen(),
    diary: (_) => const DiaryScreen(),
  };
}

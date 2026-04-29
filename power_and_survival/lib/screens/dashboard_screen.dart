import 'package:flutter/material.dart';
import '../models/game_state.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';
import '../managers/simulation_engine.dart';
import '../managers/save_manager.dart';
import '../widgets/stat_bar_widget.dart';
import '../widgets/stat_card_widget.dart';
import '../widgets/risk_bar_widget.dart';
import '../widgets/news_feed_widget.dart';
import '../widgets/warning_badge_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late GameState _gameState;
  final SimulationEngine _engine = SimulationEngine();
  final SaveManager _saveManager = SaveManager();
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is GameState) {
        _gameState = args;
      } else {
        _gameState = GameState();
      }
      _initialized = true;
    }
  }

  void _advanceMonth() {
    _engine.advanceMonth(_gameState);
    _saveManager.saveGame(_gameState);

    if (_gameState.isGameOver) {
      _gameState.currentLegacyEnding = _engine.determineLegacyEnding(_gameState);
      Navigator.pushNamed(context, AppRoutes.gameOver, arguments: _gameState);
      return;
    }

    if (_engine.electionManager.isElectionTime(_gameState)) {
      Navigator.pushNamed(context, AppRoutes.election, arguments: _gameState);
      return;
    }

    final event = _engine.getMonthlyEvent(_gameState);
    if (event != null) {
      Navigator.pushNamed(context, AppRoutes.event, arguments: {'state': _gameState, 'event': event}).then((_) {
        if (mounted) setState(() {});
      });
    } else {
      Navigator.pushNamed(context, AppRoutes.monthlyReport, arguments: _gameState).then((_) {
        if (mounted) setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_gameState.countryName} — ${_gameState.monthName}'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(icon: const Icon(Icons.save), onPressed: () { _saveManager.saveGame(_gameState); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Game saved!'))); }),
          IconButton(icon: const Icon(Icons.menu), onPressed: () => Navigator.pushNamed(context, AppRoutes.settings)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCards(),
            const SizedBox(height: 12),
            _buildWarnings(),
            const SizedBox(height: 12),
            _buildStatsSection(),
            const SizedBox(height: 12),
            _buildRisksSection(),
            const SizedBox(height: 12),
            NewsFeedWidget(headlines: _gameState.newsHistory),
            const SizedBox(height: 12),
            _buildActionButtons(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _advanceMonth,
                icon: const Icon(Icons.arrow_forward),
                label: const Text(StringsEn.nextMonth),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCards() {
    return Row(
      children: [
        Expanded(child: StatCardWidget(title: StringsEn.month, value: '${_gameState.currentMonth}', icon: Icons.calendar_today)),
        Expanded(child: StatCardWidget(title: StringsEn.treasury, value: '\$${_gameState.stats.treasury.toStringAsFixed(0)}M', icon: Icons.account_balance_wallet, color: _gameState.stats.treasury < 100 ? AppTheme.danger : null)),
        Expanded(child: StatCardWidget(title: StringsEn.approval, value: '${_gameState.stats.approvalRating.toStringAsFixed(0)}%', icon: Icons.thumb_up, color: AppTheme.getStatColor(_gameState.stats.approvalRating))),
        Expanded(child: StatCardWidget(title: StringsEn.debt, value: '\$${_gameState.stats.debt.toStringAsFixed(0)}M', icon: Icons.trending_down, color: _gameState.stats.debt > 500 ? AppTheme.danger : AppTheme.textSecondary)),
      ],
    );
  }

  Widget _buildWarnings() {
    return Wrap(
      spacing: 8, runSpacing: 4,
      children: [
        WarningBadgeWidget(text: StringsEn.warningCoup, riskLevel: _gameState.riskScores.coup),
        WarningBadgeWidget(text: StringsEn.warningRevolution, riskLevel: _gameState.riskScores.revolution),
        WarningBadgeWidget(text: StringsEn.warningBankruptcy, riskLevel: _gameState.riskScores.bankruptcy),
        WarningBadgeWidget(text: StringsEn.warningImpeachment, riskLevel: _gameState.riskScores.impeachment),
      ],
    );
  }

  Widget _buildStatsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Country Stats', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const Divider(color: AppTheme.primaryLight),
            StatBarWidget(label: StringsEn.economy, value: _gameState.stats.economy),
            StatBarWidget(label: StringsEn.happiness, value: _gameState.stats.happiness),
            StatBarWidget(label: StringsEn.military, value: _gameState.stats.military),
            StatBarWidget(label: StringsEn.corruption, value: _gameState.stats.corruption, invertColor: true),
            StatBarWidget(label: StringsEn.health, value: _gameState.stats.health),
            StatBarWidget(label: StringsEn.education, value: _gameState.stats.education),
            StatBarWidget(label: StringsEn.crime, value: _gameState.stats.crime, invertColor: true),
            StatBarWidget(label: StringsEn.stability, value: _gameState.stats.stability),
            StatBarWidget(label: StringsEn.mediaTrust, value: _gameState.stats.mediaTrust),
            StatBarWidget(label: StringsEn.internationalRelations, value: _gameState.stats.internationalRelations),
            StatBarWidget(label: StringsEn.oppositionPower, value: _gameState.stats.oppositionPower, invertColor: true),
          ],
        ),
      ),
    );
  }

  Widget _buildRisksSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Risk Assessment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.warning)),
            const Divider(color: AppTheme.primaryLight),
            RiskBarWidget(label: 'Coup', value: _gameState.riskScores.coup, icon: Icons.military_tech),
            RiskBarWidget(label: 'Revolution', value: _gameState.riskScores.revolution, icon: Icons.whatshot),
            RiskBarWidget(label: 'Bankruptcy', value: _gameState.riskScores.bankruptcy, icon: Icons.money_off),
            RiskBarWidget(label: 'Scandal', value: _gameState.riskScores.scandal, icon: Icons.report),
            RiskBarWidget(label: 'Impeachment', value: _gameState.riskScores.impeachment, icon: Icons.gavel),
            RiskBarWidget(label: 'Election Loss', value: _gameState.riskScores.electionLoss, icon: Icons.how_to_vote),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.2,
      children: [
        _actionTile(StringsEn.actions, Icons.flash_on, () => Navigator.pushNamed(context, AppRoutes.actionSelect, arguments: _gameState).then((_) { if (mounted) setState(() {}); })),
        _actionTile(StringsEn.manageBudget, Icons.pie_chart, () => Navigator.pushNamed(context, AppRoutes.budget, arguments: _gameState).then((_) { if (mounted) setState(() {}); })),
        _actionTile(StringsEn.managePolicies, Icons.policy, () => Navigator.pushNamed(context, AppRoutes.policy, arguments: _gameState).then((_) { if (mounted) setState(() {}); })),
        _actionTile(StringsEn.viewPowerCircle, Icons.groups, () => Navigator.pushNamed(context, AppRoutes.powerCircle, arguments: _gameState).then((_) { if (mounted) setState(() {}); })),
        _actionTile(StringsEn.viewPromises, Icons.checklist, () => Navigator.pushNamed(context, AppRoutes.promiseTracker, arguments: _gameState)),
        _actionTile(StringsEn.viewWorldMap, Icons.public, () => Navigator.pushNamed(context, AppRoutes.worldMap, arguments: _gameState)),
        _actionTile(StringsEn.viewDiary, Icons.book, () => Navigator.pushNamed(context, AppRoutes.diary, arguments: _gameState)),
        _actionTile(StringsEn.viewParliament, Icons.account_balance, () => Navigator.pushNamed(context, AppRoutes.parliamentVote, arguments: _gameState).then((_) { if (mounted) setState(() {}); })),
        _actionTile(StringsEn.achievements, Icons.star, () => Navigator.pushNamed(context, AppRoutes.achievements)),
      ],
    );
  }

  Widget _actionTile(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.primaryLight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppTheme.accent, size: 24),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 10), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

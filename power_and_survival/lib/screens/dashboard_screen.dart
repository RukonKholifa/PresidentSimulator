import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../models/game_state.dart';
import '../managers/simulation_engine.dart';
import '../managers/save_manager.dart';
import '../widgets/stat_bar_widget.dart';
import '../widgets/risk_bar_widget.dart';
import '../widgets/news_feed_widget.dart';
import '../widgets/warning_badge_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late GameState state;
  int actionsRemaining = 3;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is GameState) {
        state = args;
      } else {
        state = GameState.empty();
      }
      _initialized = true;
    }
  }

  void _advanceMonth() {
    final engine = SimulationEngine();
    engine.advanceMonth(state);
    SaveManager().autoSave(state);
    setState(() {
      actionsRemaining = 3;
    });

    if (state.isGameOver) {
      state.currentLegacyEnding = engine.determineLegacyEnding(state);
      Navigator.pushNamed(context, AppRoutes.gameOver, arguments: state);
      return;
    }

    if (engine.electionManager.isElectionTime(state)) {
      Navigator.pushNamed(context, AppRoutes.election, arguments: state).then((_) {
        if (mounted) setState(() {});
      });
      return;
    }

    final event = engine.getMonthlyEvent(state);
    if (event != null && mounted) {
      Navigator.pushNamed(context, AppRoutes.event, arguments: {'state': state, 'event': event}).then((_) {
        if (mounted) setState(() {});
      });
    } else if (mounted) {
      Navigator.pushNamed(context, AppRoutes.monthlyReport, arguments: state).then((_) {
        if (mounted) setState(() {});
      });
    }
  }

  void _useAction(String route, [Object? args]) {
    if (actionsRemaining <= 0) return;
    setState(() => actionsRemaining--);
    Navigator.pushNamed(context, route, arguments: args ?? state).then((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWarningBanners(),
                    const SizedBox(height: 10),
                    _buildApprovalRating(),
                    const SizedBox(height: 10),
                    _buildTreasuryDebt(),
                    const SizedBox(height: 10),
                    _buildStatGrid(),
                    const SizedBox(height: 10),
                    _buildRiskPanel(),
                    const SizedBox(height: 10),
                    NewsFeedWidget(headlines: state.newsHistory),
                    const SizedBox(height: 10),
                    _buildActionPoints(),
                    const SizedBox(height: 10),
                    _buildQuickActions(),
                    const SizedBox(height: 16),
                    _buildEndMonthButton(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 1. Top bar
  Widget _buildTopBar() {
    final monthNames = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final mi = ((state.currentMonth - 1) % 12);
    final year = state.currentYear + ((state.currentMonth - 1) ~/ 12);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      color: AppTheme.cardBackground,
      child: Row(
        children: [
          Text('${monthNames[mi]} $year', style: AppTheme.headerStyle(size: 16)),
          const Spacer(),
          Text(state.presidentName, style: AppTheme.bodyStyle(size: 12, weight: FontWeight.w600)),
          const SizedBox(width: 8),
          Text('| ${state.countryName}', style: AppTheme.bodyStyle(size: 11, color: AppTheme.textSecondary)),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoutes.settings, arguments: state),
            child: const Icon(Icons.settings, size: 18, color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  // 9. Warning banners
  Widget _buildWarningBanners() {
    final warnings = <Widget>[];
    if (state.stats.stability < 25) warnings.add(const WarningBadgeWidget(text: 'Low Stability', riskLevel: 80));
    if (state.stats.happiness < 25) warnings.add(const WarningBadgeWidget(text: 'Low Happiness', riskLevel: 80));
    if (state.stats.treasury < 50) warnings.add(const WarningBadgeWidget(text: 'Treasury Critical', riskLevel: 80));
    if (state.riskScores.coup > 60) warnings.add(WarningBadgeWidget(text: 'Coup Risk High', riskLevel: state.riskScores.coup));
    if (state.riskScores.revolution > 60) warnings.add(WarningBadgeWidget(text: 'Revolution Risk', riskLevel: state.riskScores.revolution));
    if (warnings.isEmpty) return const SizedBox.shrink();
    return Wrap(spacing: 6, runSpacing: 4, children: warnings);
  }

  // 2. Approval Rating
  Widget _buildApprovalRating() {
    final approval = state.stats.approvalRating;
    final color = AppTheme.getStatColor(approval);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.cardDecoration,
      child: Column(
        children: [
          Text('Approval Rating', style: AppTheme.bodyStyle(size: 12, color: AppTheme.textSecondary)),
          const SizedBox(height: 4),
          Text('${approval.toStringAsFixed(1)}%', style: AppTheme.headerStyle(size: 36).copyWith(color: color)),
          const SizedBox(height: 6),
          SizedBox(
            height: 8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (approval / 100).clamp(0.0, 1.0),
                backgroundColor: AppTheme.cardBorder,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Treasury & Debt
  Widget _buildTreasuryDebt() {
    final treasuryColor = state.stats.treasury > 200 ? AppTheme.success : (state.stats.treasury > 0 ? AppTheme.warning : AppTheme.danger);
    final debtColor = state.stats.debt > 500 ? AppTheme.danger : (state.stats.debt > 0 ? AppTheme.warning : AppTheme.success);
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: AppTheme.cardDecoration,
            child: Column(
              children: [
                const Icon(Icons.account_balance_wallet, size: 18, color: AppTheme.accent),
                const SizedBox(height: 4),
                Text('Treasury', style: AppTheme.bodyStyle(size: 10, color: AppTheme.textSecondary)),
                Text('\$${state.stats.treasury.toStringAsFixed(0)}M', style: AppTheme.headerStyle(size: 18).copyWith(color: treasuryColor)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: AppTheme.cardDecoration,
            child: Column(
              children: [
                const Icon(Icons.trending_down, size: 18, color: AppTheme.danger),
                const SizedBox(height: 4),
                Text('Debt', style: AppTheme.bodyStyle(size: 10, color: AppTheme.textSecondary)),
                Text('\$${state.stats.debt.toStringAsFixed(0)}M', style: AppTheme.headerStyle(size: 18).copyWith(color: debtColor)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // 4. Stat grid (14 stats, 2 columns)
  Widget _buildStatGrid() {
    final stats = [
      ('Economy', state.stats.economy, Icons.show_chart),
      ('Happiness', state.stats.happiness, Icons.sentiment_satisfied),
      ('Military', state.stats.military, Icons.military_tech),
      ('Corruption', 100 - state.stats.corruption, Icons.gavel),
      ('Health', state.stats.health, Icons.favorite),
      ('Education', state.stats.education, Icons.school),
      ('Crime', 100 - state.stats.crime, Icons.shield),
      ('Intl Relations', state.stats.internationalRelations, Icons.public),
      ('Stability', state.stats.stability, Icons.balance),
      ('Media Trust', state.stats.mediaTrust, Icons.campaign),
      ('Opposition', 100 - state.stats.oppositionPower, Icons.groups),
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Country Stats', style: AppTheme.headerStyle(size: 14)),
          const SizedBox(height: 8),
          ...List.generate((stats.length / 2).ceil(), (i) {
            final left = stats[i * 2];
            final right = i * 2 + 1 < stats.length ? stats[i * 2 + 1] : null;
            return Row(
              children: [
                Expanded(child: StatBarWidget(label: left.$1, value: left.$2, icon: left.$3)),
                const SizedBox(width: 8),
                Expanded(
                  child: right != null
                      ? StatBarWidget(label: right.$1, value: right.$2, icon: right.$3)
                      : const SizedBox(),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  // 5. Risk scores panel
  Widget _buildRiskPanel() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Risk Assessment', style: AppTheme.headerStyle(size: 14)),
          const SizedBox(height: 8),
          RiskBarWidget(label: 'Coup Risk', value: state.riskScores.coup, icon: Icons.dangerous),
          RiskBarWidget(label: 'Revolution', value: state.riskScores.revolution, icon: Icons.local_fire_department),
          RiskBarWidget(label: 'Bankruptcy', value: state.riskScores.bankruptcy, icon: Icons.attach_money),
          RiskBarWidget(label: 'Scandal', value: state.riskScores.scandal, icon: Icons.camera_alt),
          RiskBarWidget(label: 'Impeachment', value: state.riskScores.impeachment, icon: Icons.gavel),
          RiskBarWidget(label: 'Election Loss', value: state.riskScores.electionLoss, icon: Icons.how_to_vote),
        ],
      ),
    );
  }

  // 7. Action points
  Widget _buildActionPoints() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppTheme.cardDecoration,
      child: Row(
        children: [
          Text('Actions: ', style: AppTheme.headerStyle(size: 14)),
          const SizedBox(width: 8),
          ...List.generate(3, (i) => Padding(
            padding: const EdgeInsets.only(right: 6),
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i < actionsRemaining ? AppTheme.accent : AppTheme.cardBorder,
              ),
              child: Icon(
                Icons.bolt,
                size: 14,
                color: i < actionsRemaining ? AppTheme.background : AppTheme.textSecondary,
              ),
            ),
          )),
          const Spacer(),
          Text('$actionsRemaining remaining', style: AppTheme.bodyStyle(size: 11, color: AppTheme.textSecondary)),
        ],
      ),
    );
  }

  // 8. Quick access buttons
  Widget _buildQuickActions() {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.0,
      children: [
        _quickButton('Budget', Icons.account_balance_wallet, () => _useAction(AppRoutes.budget)),
        _quickButton('Policies', Icons.policy, () => _useAction(AppRoutes.policy)),
        _quickButton('Cabinet', Icons.people, () => _useAction(AppRoutes.powerCircle)),
        _quickButton('World', Icons.public, () => _useAction(AppRoutes.worldMap)),
        _quickButton('Actions', Icons.flash_on, () => _useAction(AppRoutes.actionSelect)),
        _quickButton('Promises', Icons.handshake, () => Navigator.pushNamed(context, AppRoutes.promiseTracker, arguments: state)),
        _quickButton('Diary', Icons.book, () => Navigator.pushNamed(context, AppRoutes.diary, arguments: state)),
        _quickButton('Save', Icons.save, () async {
          await SaveManager().saveGame(state, 0);
          if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Game saved')));
        }),
      ],
    );
  }

  Widget _quickButton(String label, IconData icon, VoidCallback onTap) {
    return Material(
      color: AppTheme.cardBackground,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.cardBorder),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: AppTheme.accent),
              const SizedBox(height: 4),
              Text(label, style: AppTheme.bodyStyle(size: 10, weight: FontWeight.w600), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEndMonthButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: state.isGameOver ? null : _advanceMonth,
        icon: const Icon(Icons.skip_next, size: 20),
        label: Text(state.isGameOver ? 'Game Over' : 'End Month'),
      ),
    );
  }
}

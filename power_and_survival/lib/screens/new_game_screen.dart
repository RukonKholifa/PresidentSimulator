import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../config/game_balance.dart';
import '../models/game_state.dart';
import '../models/country_stats.dart';
import '../models/citizen_groups.dart';
import '../models/risk_scores.dart';
import '../managers/character_manager.dart';
import '../models/neighbor_country.dart';
import '../data/country_traits_data.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  final _nameController = TextEditingController(text: 'President');
  final _countryController = TextEditingController(text: 'Republic of Valdoria');
  final _partyController = TextEditingController(text: 'Unity Party');
  String _difficulty = 'normal';
  String _ideology = 'centrist';
  String _countryTrait = 'balanced';
  String _inheritedCrisis = 'none';

  final _difficulties = ['easy', 'normal', 'hard', 'dictator'];
  final _ideologies = ['centrist', 'socialist', 'conservative', 'liberal', 'nationalist'];
  final _crises = ['none', 'economic_collapse', 'civil_unrest', 'corruption_scandal', 'military_tension'];

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _partyController.dispose();
    super.dispose();
  }

  void _startGame() {
    final starting = GameBalance.startingStats[_difficulty] ?? GameBalance.startingStats['normal']!;
    final trait = CountryTraitsData.getStatModifiers(_countryTrait);
    final stats = CountryStats(
      economy: starting['economy']! + (trait['economy'] ?? 0),
      happiness: starting['happiness']! + (trait['happiness'] ?? 0),
      military: starting['military']! + (trait['military'] ?? 0),
      corruption: starting['corruption']! + (trait['corruption'] ?? 0),
      health: starting['health']! + (trait['health'] ?? 0),
      education: starting['education']! + (trait['education'] ?? 0),
      crime: starting['crime']! + (trait['crime'] ?? 0),
      internationalRelations: starting['internationalRelations']! + (trait['internationalRelations'] ?? 0),
      stability: starting['stability']! + (trait['stability'] ?? 0),
      mediaTrust: starting['mediaTrust']! + (trait['mediaTrust'] ?? 0),
      oppositionPower: starting['oppositionPower']! + (trait['oppositionPower'] ?? 0),
      approvalRating: starting['approvalRating']! + (trait['approvalRating'] ?? 0),
      treasury: starting['treasury']! + (trait['treasury'] ?? 0),
      debt: starting['debt']! + (trait['debt'] ?? 0),
    );
    stats.clamp();

    final characters = CharacterManager().generateStartingCharacters();

    final state = GameState(
      presidentName: _nameController.text.trim().isEmpty ? 'President' : _nameController.text.trim(),
      countryName: _countryController.text.trim().isEmpty ? 'Republic of Valdoria' : _countryController.text.trim(),
      partyName: _partyController.text.trim().isEmpty ? 'Unity Party' : _partyController.text.trim(),
      ideology: _ideology,
      difficulty: _difficulty,
      countryTrait: _countryTrait,
      inheritedCrisis: _inheritedCrisis,
      currentMonth: 1,
      currentYear: 2025,
      currentTerm: 1,
      stats: stats,
      citizenGroups: CitizenGroups(),
      riskScores: RiskScores(),
      characters: characters,
      budgetAllocation: {
        'health': 0.15, 'education': 0.12, 'military': 0.12, 'security': 0.10,
        'infrastructure': 0.12, 'welfare': 0.10, 'reserve': 0.10, 'debtPayment': 0.10,
        'foreign_affairs': 0.05, 'intelligence': 0.04,
      },
      activePolicyIds: [],
      activePromises: [],
      neighbors: [
        NeighborCountry(id: 'north', name: 'Nordland', governmentType: 'Democracy', relationScore: 60, militaryStrength: 'high', economicStrength: 'high'),
        NeighborCountry(id: 'east', name: 'Eastmark', governmentType: 'Authoritarian', relationScore: 40, militaryStrength: 'medium', economicStrength: 'medium'),
        NeighborCountry(id: 'south', name: 'Southvale', governmentType: 'Democracy', relationScore: 55, militaryStrength: 'low', economicStrength: 'low'),
        NeighborCountry(id: 'west', name: 'Westreach', governmentType: 'Monarchy', relationScore: 50, militaryStrength: 'medium', economicStrength: 'high'),
      ],
      eventHistory: [],
      decisionHistory: [],
      newsHistory: [],
      diaryEntries: [],
      earnedAchievements: [],
      activeCrisisChains: [],
    );

    Navigator.pushReplacementNamed(context, AppRoutes.dashboard, arguments: state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Game')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('President Setup', style: AppTheme.headerStyle(size: 18)),
            const SizedBox(height: 12),
            _field('President Name', _nameController),
            _field('Country Name', _countryController),
            _field('Party Name', _partyController),
            const SizedBox(height: 16),
            Text('Difficulty', style: AppTheme.headerStyle(size: 16)),
            const SizedBox(height: 8),
            _chipSelector(_difficulties, _difficulty, (v) => setState(() => _difficulty = v)),
            const SizedBox(height: 16),
            Text('Ideology', style: AppTheme.headerStyle(size: 16)),
            const SizedBox(height: 8),
            _chipSelector(_ideologies, _ideology, (v) => setState(() => _ideology = v)),
            const SizedBox(height: 16),
            Text('Country Trait', style: AppTheme.headerStyle(size: 16)),
            const SizedBox(height: 8),
            _chipSelector(CountryTraitsData.traitIds, _countryTrait, (v) => setState(() => _countryTrait = v)),
            const SizedBox(height: 16),
            Text('Inherited Crisis', style: AppTheme.headerStyle(size: 16)),
            const SizedBox(height: 8),
            _chipSelector(_crises, _inheritedCrisis, (v) => setState(() => _inheritedCrisis = v)),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _startGame,
                child: const Text('BEGIN YOUR PRESIDENCY'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        style: AppTheme.bodyStyle(),
      ),
    );
  }

  Widget _chipSelector(List<String> options, String selected, ValueChanged<String> onSelect) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: options.map((opt) {
        final isSelected = opt == selected;
        return ChoiceChip(
          label: Text(opt.replaceAll('_', ' '), style: AppTheme.bodyStyle(
            size: 12,
            color: isSelected ? AppTheme.background : AppTheme.textPrimary,
          )),
          selected: isSelected,
          selectedColor: AppTheme.accent,
          backgroundColor: AppTheme.cardBackground,
          side: BorderSide(color: isSelected ? AppTheme.accent : AppTheme.cardBorder),
          onSelected: (_) => onSelect(opt),
        );
      }).toList(),
    );
  }
}

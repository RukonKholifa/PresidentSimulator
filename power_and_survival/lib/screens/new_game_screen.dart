import 'package:flutter/material.dart';
import '../config/theme.dart';
import '../config/routes.dart';
import '../data/strings_en.dart';
import '../data/country_traits_data.dart';
import '../managers/simulation_engine.dart';

class NewGameScreen extends StatefulWidget {
  const NewGameScreen({super.key});

  @override
  State<NewGameScreen> createState() => _NewGameScreenState();
}

class _NewGameScreenState extends State<NewGameScreen> {
  final _nameController = TextEditingController(text: 'President');
  final _countryController = TextEditingController(text: 'Republic of Valoria');
  final _partyController = TextEditingController(text: 'Unity Party');
  String _ideology = 'centrist';
  String _difficulty = 'normal';
  String _countryTrait = 'balanced';

  final _ideologies = ['centrist', 'progressive', 'conservative', 'socialist', 'nationalist', 'libertarian'];
  final _difficulties = ['easy', 'normal', 'hard', 'dictator'];

  @override
  void dispose() {
    _nameController.dispose();
    _countryController.dispose();
    _partyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StringsEn.createYourPresident)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(StringsEn.presidentName, _nameController, StringsEn.enterPresidentName),
            const SizedBox(height: 12),
            _buildTextField(StringsEn.countryName, _countryController, StringsEn.enterCountryName),
            const SizedBox(height: 12),
            _buildTextField(StringsEn.partyName, _partyController, StringsEn.enterPartyName),
            const SizedBox(height: 20),
            _buildSectionTitle(StringsEn.selectIdeology),
            Wrap(
              spacing: 8, runSpacing: 8,
              children: _ideologies.map((i) => _buildChip(i, _ideology == i, () => setState(() => _ideology = i))).toList(),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle(StringsEn.selectDifficulty),
            ..._difficulties.map((d) => _buildDifficultyOption(d)),
            const SizedBox(height: 20),
            _buildSectionTitle(StringsEn.selectCountryTrait),
            ...CountryTraitsData.traitIds.map((t) => _buildTraitOption(t)),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _startGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accent,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(StringsEn.startGame, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label, hintText: hint),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.gold)),
    );
  }

  Widget _buildChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        label: Text(label.toUpperCase(), style: TextStyle(fontSize: 12, color: selected ? AppTheme.primaryDark : AppTheme.textPrimary)),
        backgroundColor: selected ? AppTheme.gold : AppTheme.cardBackground,
      ),
    );
  }

  Widget _buildDifficultyOption(String difficulty) {
    final isSelected = _difficulty == difficulty;
    final descriptions = {
      'easy': StringsEn.easyDesc, 'normal': StringsEn.normalDesc,
      'hard': StringsEn.hardDesc, 'dictator': StringsEn.dictatorDesc,
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => setState(() => _difficulty = difficulty),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: isSelected ? AppTheme.accent : AppTheme.primaryLight),
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? AppTheme.accent.withValues(alpha: 0.1) : null,
          ),
          child: Row(
            children: [
              Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelected ? AppTheme.accent : AppTheme.textSecondary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(difficulty.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? AppTheme.accent : AppTheme.textPrimary)),
                    Text(descriptions[difficulty] ?? '', style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTraitOption(String traitId) {
    final trait = CountryTraitsData.allTraits[traitId]!;
    final isSelected = _countryTrait == traitId;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () => setState(() => _countryTrait = traitId),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: isSelected ? AppTheme.gold : AppTheme.primaryLight),
            borderRadius: BorderRadius.circular(8),
            color: isSelected ? AppTheme.gold.withValues(alpha: 0.1) : null,
          ),
          child: Row(
            children: [
              Icon(isSelected ? Icons.check_circle : Icons.circle_outlined, color: isSelected ? AppTheme.gold : AppTheme.textSecondary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(trait['name'] as String, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? AppTheme.gold : AppTheme.textPrimary)),
                    Text(trait['description'] as String, style: const TextStyle(fontSize: 11, color: AppTheme.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startGame() {
    final engine = SimulationEngine();
    final state = engine.createNewGame(
      presidentName: _nameController.text.trim().isEmpty ? 'President' : _nameController.text.trim(),
      countryName: _countryController.text.trim().isEmpty ? 'Republic' : _countryController.text.trim(),
      partyName: _partyController.text.trim().isEmpty ? 'Unity Party' : _partyController.text.trim(),
      ideology: _ideology,
      difficulty: _difficulty,
      countryTrait: _countryTrait,
    );
    Navigator.pushReplacementNamed(context, AppRoutes.dashboard, arguments: state);
  }
}

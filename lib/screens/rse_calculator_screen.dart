import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class RseCalculatorScreen extends StatefulWidget {
  const RseCalculatorScreen({super.key});

  @override
  State<RseCalculatorScreen> createState() => _RseCalculatorScreenState();
}

class _RseCalculatorScreenState extends State<RseCalculatorScreen>
    with TickerProviderStateMixin {
  int _quantity = 100;
  String _selectedProduct = 'stylo';
  bool _showResults = false;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  final Map<String, Map<String, dynamic>> _products = {
    'stylo': {
      'label': 'Stylo recyclé',
      'co2_per_unit': 0.012,
      'rse_score': 3,
      'recycled_pct': 60,
      'tree_factor': 0.002,
    },
    'tote_bag': {
      'label': 'Tote bag bio',
      'co2_per_unit': 0.08,
      'rse_score': 5,
      'recycled_pct': 100,
      'tree_factor': 0.01,
    },
    'carnet': {
      'label': 'Carnet FSC',
      'co2_per_unit': 0.045,
      'rse_score': 4,
      'recycled_pct': 80,
      'tree_factor': 0.006,
    },
    'gourde': {
      'label': 'Gourde inox',
      'co2_per_unit': 0.15,
      'rse_score': 5,
      'recycled_pct': 90,
      'tree_factor': 0.02,
    },
    'cle_usb': {
      'label': 'Clé USB éco',
      'co2_per_unit': 0.09,
      'rse_score': 3,
      'recycled_pct': 50,
      'tree_factor': 0.008,
    },
    'tshirt': {
      'label': 'T-shirt coton bio',
      'co2_per_unit': 0.2,
      'rse_score': 4,
      'recycled_pct': 100,
      'tree_factor': 0.025,
    },
  };

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  double get _co2Saved =>
      _quantity * (_products[_selectedProduct]!['co2_per_unit'] as double) * 0.4;

  double get _trees =>
      _quantity * (_products[_selectedProduct]!['tree_factor'] as double);

  int get _rseScore => _products[_selectedProduct]!['rse_score'] as int;

  int get _recycledPct => _products[_selectedProduct]!['recycled_pct'] as int;

  void _calculate() {
    HapticFeedback.mediumImpact();
    setState(() => _showResults = true);
    _animController.forward(from: 0);
  }

  void _reset() {
    setState(() {
      _showResults = false;
      _quantity = 100;
      _selectedProduct = 'stylo';
    });
    _animController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Calculateur RSE'),
        centerTitle: false,
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.blue, AppColors.blueDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 3,
                    decoration: BoxDecoration(
                      color: AppColors.teal,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Mesurez votre\nimpact écologique',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Calculez le bilan RSE de votre commande d\'objets média.',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Product selector
            const Text(
              'TYPE DE PRODUIT',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppColors.blue,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _products.entries.map((entry) {
                final isSelected = _selectedProduct == entry.key;
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() {
                      _selectedProduct = entry.key;
                      _showResults = false;
                      _animController.reset();
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.blue : AppColors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: isSelected ? AppColors.blue : AppColors.greyBorder,
                        width: 1.5,
                      ),
                      boxShadow: isSelected
                          ? [BoxShadow(color: AppColors.blue.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 3))]
                          : [],
                    ),
                    child: Text(
                      entry.value['label'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? Colors.white : AppColors.dark,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),

            // Quantity slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'QUANTITÉ',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.blue,
                    letterSpacing: 1.5,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.teal,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    '$_quantity unités',
                    style: const TextStyle(
                      color: AppColors.blue,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: AppColors.blue,
                inactiveTrackColor: AppColors.greyLight,
                thumbColor: AppColors.teal,
                overlayColor: AppColors.teal.withOpacity(0.2),
                trackHeight: 6,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              ),
              child: Slider(
                value: _quantity.toDouble(),
                min: 10,
                max: 5000,
                divisions: 99,
                onChanged: (val) {
                  setState(() {
                    _quantity = val.round();
                    _showResults = false;
                    _animController.reset();
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('10', style: TextStyle(fontSize: 11, color: AppColors.greyText)),
                Text('1000', style: TextStyle(fontSize: 11, color: AppColors.greyText)),
                Text('5000', style: TextStyle(fontSize: 11, color: AppColors.greyText)),
              ],
            ),
            const SizedBox(height: 28),

            // Calculate button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _calculate,
                icon: const Icon(Icons.eco, size: 18, color: AppColors.blue),
                label: const Text(
                  'Calculer mon impact RSE',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.blue),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Results
            if (_showResults)
              FadeTransition(
                opacity: _fadeAnim,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'VOTRE IMPACT',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.blue,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(child: _ResultCard(emoji: '💨', value: '${_co2Saved.toStringAsFixed(1)} kg', label: 'CO₂ économisé', color: AppColors.blue)),
                        const SizedBox(width: 12),
                        Expanded(child: _ResultCard(emoji: '🌳', value: '${_trees.toStringAsFixed(1)}', label: 'Arbres équivalents', color: AppColors.blueMid)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _ResultCard(emoji: '♻️', value: '$_recycledPct%', label: 'Matériaux recyclés', color: AppColors.teal)),
                        const SizedBox(width: 12),
                        Expanded(child: _RseScoreCard(score: _rseScore)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('✅ Résumé copié !'),
                              backgroundColor: AppColors.blue,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        },
                        icon: const Icon(Icons.share, size: 18, color: AppColors.blue),
                        label: const Text('Partager mon impact', style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.w800)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.teal,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _reset,
                        icon: const Icon(Icons.refresh, size: 16),
                        label: const Text('Nouveau calcul'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.blue,
                          side: const BorderSide(color: AppColors.blue, width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;
  final Color color;

  const _ResultCard({required this.emoji, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: color)),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.greyText, height: 1.3)),
        ],
      ),
    );
  }
}

class _RseScoreCard extends StatelessWidget {
  final int score;
  const _RseScoreCard({required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.tealLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.teal.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🏅', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 8),
          Row(
            children: List.generate(5, (i) => Icon(
              i < score ? Icons.star_rounded : Icons.star_outline_rounded,
              color: AppColors.teal,
              size: 18,
            )),
          ),
          const SizedBox(height: 4),
          const Text('Score RSE', style: TextStyle(fontSize: 11, color: AppColors.greyText)),
        ],
      ),
    );
  }
}

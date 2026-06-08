import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

// ── DATA ─────────────────────────────────────────────────────

const List<Map<String, dynamic>> _secteurs = [
  {'label': 'Aéronautique & Défense', 'icon': FontAwesomeIcons.plane},
  {'label': 'Technologie & IT', 'icon': FontAwesomeIcons.microchip},
  {'label': 'Santé & Pharma', 'icon': FontAwesomeIcons.heartPulse},
  {'label': 'Industrie & Énergie', 'icon': FontAwesomeIcons.industry},
  {'label': 'Finance & Assurance', 'icon': FontAwesomeIcons.buildingColumns},
  {'label': 'Retail & Distribution', 'icon': FontAwesomeIcons.store},
  {'label': 'Automobile', 'icon': FontAwesomeIcons.car},
  {'label': 'Autre', 'icon': FontAwesomeIcons.briefcase},
];

const List<Map<String, dynamic>> _objectifs = [
  {'label': 'Fidélisation client', 'icon': FontAwesomeIcons.heart, 'desc': 'Renforcer la relation avec vos clients'},
  {'label': 'Événement / Salon', 'icon': FontAwesomeIcons.calendarCheck, 'desc': 'Marquer les esprits lors d\'un événement'},
  {'label': 'Cadeau collaborateur', 'icon': FontAwesomeIcons.gift, 'desc': 'Valoriser vos équipes'},
  {'label': 'Onboarding', 'icon': FontAwesomeIcons.handshake, 'desc': 'Accueillir nouveaux clients / employés'},
  {'label': 'Notoriété de marque', 'icon': FontAwesomeIcons.star, 'desc': 'Augmenter votre visibilité'},
  {'label': 'RSE / Engagement', 'icon': FontAwesomeIcons.leaf, 'desc': 'Communication responsable'},
];

const List<Map<String, dynamic>> _budgets = [
  {'label': '< 1 000 €', 'range': '< 1 000 €', 'icon': FontAwesomeIcons.euroSign},
  {'label': '1 000 — 5 000 €', 'range': '1k–5k', 'icon': FontAwesomeIcons.euroSign},
  {'label': '5 000 — 15 000 €', 'range': '5k–15k', 'icon': FontAwesomeIcons.euroSign},
  {'label': '15 000 — 50 000 €', 'range': '15k–50k', 'icon': FontAwesomeIcons.euroSign},
  {'label': '> 50 000 €', 'range': '> 50k', 'icon': FontAwesomeIcons.euroSign},
];

const List<Map<String, dynamic>> _quantites = [
  {'label': '50 — 100', 'icon': FontAwesomeIcons.cubes},
  {'label': '100 — 500', 'icon': FontAwesomeIcons.cubes},
  {'label': '500 — 1 000', 'icon': FontAwesomeIcons.cubes},
  {'label': '1 000 — 5 000', 'icon': FontAwesomeIcons.cubes},
  {'label': '+ 5 000', 'icon': FontAwesomeIcons.cubes},
];

// Recommendations based on objectif
Map<String, List<Map<String, dynamic>>> _recommendations = {
  'Fidélisation client': [
    {'name': 'Gourde inox premium', 'desc': 'Objet du quotidien, fort taux d\'utilisation', 'rse': 5, 'url': 'https://selection-by-synneo.fr/categorie/17-3833249-gourde-bouteille-publicitaire-goodies-personnalise'},
    {'name': 'Carnet FSC cuir', 'desc': 'Élégant et durable, idéal cadeau B2B', 'rse': 4, 'url': 'https://selection-by-synneo.fr/categorie/95-3833165-carnet-publicitaire-goodies-personnalise'},
    {'name': 'Coffret bien-être', 'desc': 'Sélection de produits premium personnalisés', 'rse': 4, 'url': 'https://selection-by-synneo.fr'},
  ],
  'Événement / Salon': [
    {'name': 'Tote bag coton bio', 'desc': 'Visibilité maximale, transportable', 'rse': 5, 'url': 'https://selection-by-synneo.fr/categorie/57-3833378-sacs-totebag-publicitaire-goodies-personnalise'},
    {'name': 'Stylo bambou', 'desc': 'Distribué en masse, impact positif', 'rse': 4, 'url': 'https://selection-by-synneo.fr/categorie/68-3833255-stylo-publicitaire-goodies-personnalise'},
    {'name': 'Badge / Lanyard éco', 'desc': 'Indispensable en événementiel', 'rse': 3, 'url': 'https://selection-by-synneo.fr'},
  ],
  'Cadeau collaborateur': [
    {'name': 'Sweat-shirt bio', 'desc': 'Confort et fierté d\'appartenance', 'rse': 5, 'url': 'https://selection-by-synneo.fr/categorie/48-3833052-sweats-pulls-publicitaire-goodies-personnalise'},
    {'name': 'Mug céramique France', 'desc': 'Fabriqué en France, quotidien au bureau', 'rse': 5, 'url': 'https://selection-by-synneo.fr/categorie/62-3833156-mugs-tasse-publicitaire-goodies-personnalise'},
    {'name': 'Lunchbox inox', 'desc': 'Zéro déchet, pratique chaque jour', 'rse': 5, 'url': 'https://selection-by-synneo.fr/categorie/950-lunchbox-publicitaire-goodies-personnalise'},
  ],
  'Onboarding': [
    {'name': 'Kit bienvenue', 'desc': 'Carnet + stylo + tote bag personnalisés', 'rse': 4, 'url': 'https://selection-by-synneo.fr'},
    {'name': 'Polo piqué bio', 'desc': 'Uniforme responsable pour les équipes', 'rse': 4, 'url': 'https://selection-by-synneo.fr/categorie/102-3833055-polo-publicitaire-goodies-personnalise'},
    {'name': 'Sac à dos recyclé', 'desc': 'Fonctionnel, durable, personnalisable', 'rse': 4, 'url': 'https://selection-by-synneo.fr/categorie/83-3833317-sacs-a-dos-publicitaire-goodies-personnalise'},
  ],
  'Notoriété de marque': [
    {'name': 'Enceinte bambou', 'desc': 'Tech & éco, objet premium remarqué', 'rse': 5, 'url': 'https://selection-by-synneo.fr/categorie/268-4839811-enceinte-objet-publicitaire-goodies-personnalise'},
    {'name': 'Chargeur solaire', 'desc': 'Innovation & responsabilité en un objet', 'rse': 4, 'url': 'https://selection-by-synneo.fr/categorie/265-4839819-cable-objet-publicitaire-goodies-personnalise'},
    {'name': 'T-shirt coton bio', 'desc': 'Vos équipes sont vos ambassadeurs', 'rse': 5, 'url': 'https://selection-by-synneo.fr/categorie/54-12473384-tshirt-publicitaire-goodies-personnalise'},
  ],
  'RSE / Engagement': [
    {'name': 'Kit zéro déchet', 'desc': 'Gourde + lunchbox + couverts bambou', 'rse': 5, 'url': 'https://selection-by-synneo.fr/categorie/1639-zero-dechet'},
    {'name': 'Tote bag coton bio', 'desc': 'Alternatif aux sacs plastiques', 'rse': 5, 'url': 'https://selection-by-synneo.fr/categorie/57-3833378-sacs-totebag-publicitaire-goodies-personnalise'},
    {'name': 'Carnet papier recyclé', 'desc': 'Certifié FSC, impact carbone réduit', 'rse': 5, 'url': 'https://selection-by-synneo.fr/categorie/95-3833165-carnet-publicitaire-goodies-personnalise'},
  ],
};

// ── MAIN SCREEN ───────────────────────────────────────────────
class ConfigurateurScreen extends StatefulWidget {
  const ConfigurateurScreen({super.key});

  @override
  State<ConfigurateurScreen> createState() => _ConfigurateurScreenState();
}

class _ConfigurateurScreenState extends State<ConfigurateurScreen> {
  int _step = 0; // 0=intro, 1=secteur, 2=objectif, 3=budget, 4=quantite, 5=résultats
  String? _secteur;
  String? _objectif;
  String? _budget;
  String? _quantite;

  void _next() {
    HapticFeedback.lightImpact();
    setState(() => _step++);
  }

  void _back() {
    HapticFeedback.lightImpact();
    if (_step > 0) setState(() => _step--);
  }

  void _reset() {
    setState(() {
      _step = 0;
      _secteur = null;
      _objectif = null;
      _budget = null;
      _quantite = null;
    });
  }

  List<Map<String, dynamic>> get _results {
    if (_objectif == null) return [];
    return _recommendations[_objectif] ?? _recommendations['Fidélisation client']!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.white,
            leading: _step > 0 && _step < 5
                ? IconButton(icon: const Icon(Icons.arrow_back, color: AppColors.blue), onPressed: _back)
                : null,
            title: const Text('Configurateur'),
            centerTitle: false,
            bottom: _step > 0 && _step < 5
                ? PreferredSize(
                    preferredSize: const Size.fromHeight(4),
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(color: AppColors.greyBorder, borderRadius: BorderRadius.circular(2)),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: _step / 4,
                        child: Container(decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(2))),
                      ),
                    ),
                  )
                : null,
          ),
          SliverToBoxAdapter(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, anim) => FadeTransition(opacity: anim, child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero).animate(anim),
                child: child,
              )),
              child: KeyedSubtree(
                key: ValueKey(_step),
                child: _buildStep(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep() {
    switch (_step) {
      case 0: return _IntroStep(onStart: _next);
      case 1: return _SelectionStep(
        title: 'Votre secteur',
        subtitle: 'Étape 1 sur 4',
        question: 'Dans quel secteur opérez-vous ?',
        options: _secteurs,
        selected: _secteur,
        onSelect: (v) { setState(() => _secteur = v); Future.delayed(const Duration(milliseconds: 200), _next); },
      );
      case 2: return _SelectionStep(
        title: 'Votre objectif',
        subtitle: 'Étape 2 sur 4',
        question: 'Quel est l\'objectif de votre campagne ?',
        options: _objectifs,
        selected: _objectif,
        showDesc: true,
        onSelect: (v) { setState(() => _objectif = v); Future.delayed(const Duration(milliseconds: 200), _next); },
      );
      case 3: return _SelectionStep(
        title: 'Votre budget',
        subtitle: 'Étape 3 sur 4',
        question: 'Quel est votre budget global ?',
        options: _budgets,
        selected: _budget,
        onSelect: (v) { setState(() => _budget = v); Future.delayed(const Duration(milliseconds: 200), _next); },
      );
      case 4: return _SelectionStep(
        title: 'Votre quantité',
        subtitle: 'Étape 4 sur 4',
        question: 'Quelle quantité envisagez-vous ?',
        options: _quantites,
        selected: _quantite,
        onSelect: (v) { setState(() => _quantite = v); Future.delayed(const Duration(milliseconds: 300), _next); },
      );
      case 5: return _ResultsStep(
        secteur: _secteur ?? '',
        objectif: _objectif ?? '',
        budget: _budget ?? '',
        quantite: _quantite ?? '',
        results: _results,
        onReset: _reset,
      );
      default: return const SizedBox();
    }
  }
}

// ── INTRO ─────────────────────────────────────────────────────
class _IntroStep extends StatelessWidget {
  final VoidCallback onStart;
  const _IntroStep({required this.onStart});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.blue, AppColors.blueDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned(right: -16, top: -16, child: Container(
                  width: 100, height: 100,
                  decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.teal.withOpacity(0.2), width: 16)),
                )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: AppColors.teal.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                      child: const FaIcon(FontAwesomeIcons.wandMagicSparkles, color: AppColors.teal, size: 24),
                    ),
                    const SizedBox(height: 16),
                    const Text('CONFIGURATEUR\nDE PROJET', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white, height: 1.15)),
                    const SizedBox(height: 8),
                    Text('Répondez à 4 questions et recevez une sélection de produits personnalisée pour votre campagne.', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8), height: 1.5)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Steps preview
          const Text('COMMENT ÇA MARCHE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1.5)),
          const SizedBox(height: 16),
          _StepPreview(num: '01', title: 'Votre secteur', desc: 'Dites-nous dans quel domaine vous opérez'),
          _StepPreview(num: '02', title: 'Votre objectif', desc: 'Fidélisation, événement, cadeau...'),
          _StepPreview(num: '03', title: 'Votre budget', desc: 'Une enveloppe globale pour votre campagne'),
          _StepPreview(num: '04', title: 'Votre quantité', desc: 'Le volume d\'objets souhaité'),
          const SizedBox(height: 8),
          _StepPreview(num: '✓', title: 'Votre sélection', desc: 'Produits recommandés + demande de devis', isResult: true),
          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onStart,
              icon: const Icon(Icons.arrow_forward, size: 16, color: AppColors.blue),
              label: const Text('Commencer', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.blue)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.teal,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _StepPreview extends StatelessWidget {
  final String num;
  final String title;
  final String desc;
  final bool isResult;
  const _StepPreview({required this.num, required this.title, required this.desc, this.isResult = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: isResult ? AppColors.teal : AppColors.tealLight,
              shape: BoxShape.circle,
            ),
            child: Center(child: Text(num, style: TextStyle(fontSize: isResult ? 12 : 11, fontWeight: FontWeight.w900, color: AppColors.blue))),
          ),
          const SizedBox(width: 14),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.dark)),
              Text(desc, style: const TextStyle(fontSize: 11, color: AppColors.greyText)),
            ],
          )),
        ],
      ),
    );
  }
}

// ── SELECTION STEP ────────────────────────────────────────────
class _SelectionStep extends StatelessWidget {
  final String title;
  final String subtitle;
  final String question;
  final List<Map<String, dynamic>> options;
  final String? selected;
  final bool showDesc;
  final ValueChanged<String> onSelect;

  const _SelectionStep({
    required this.title,
    required this.subtitle,
    required this.question,
    required this.options,
    required this.selected,
    required this.onSelect,
    this.showDesc = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(subtitle, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.teal, letterSpacing: 1.5)),
          const SizedBox(height: 6),
          Text(question, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.blue, height: 1.2)),
          const SizedBox(height: 20),
          ...options.map((opt) {
            final isSelected = selected == opt['label'];
            return GestureDetector(
              onTap: () => onSelect(opt['label'] as String),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.blue : AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? AppColors.blue : AppColors.greyBorder,
                    width: 1.5,
                  ),
                  boxShadow: isSelected ? [BoxShadow(color: AppColors.blue.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))] : [BoxShadow(color: AppColors.blue.withOpacity(0.04), blurRadius: 6, offset: const Offset(0, 2))],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36, height: 36,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.teal.withOpacity(0.2) : AppColors.tealLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: FaIcon(opt['icon'] as IconData, size: 15, color: isSelected ? AppColors.teal : AppColors.blue)),
                    ),
                    const SizedBox(width: 14),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(opt['label'] as String, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: isSelected ? Colors.white : AppColors.dark)),
                        if (showDesc && opt['desc'] != null)
                          Text(opt['desc'] as String, style: TextStyle(fontSize: 11, color: isSelected ? Colors.white.withOpacity(0.7) : AppColors.greyText)),
                      ],
                    )),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: AppColors.teal, size: 20)
                    else
                      const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.greyBorder),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ── RESULTS ───────────────────────────────────────────────────
class _ResultsStep extends StatelessWidget {
  final String secteur;
  final String objectif;
  final String budget;
  final String quantite;
  final List<Map<String, dynamic>> results;
  final VoidCallback onReset;

  const _ResultsStep({
    required this.secteur,
    required this.objectif,
    required this.budget,
    required this.quantite,
    required this.results,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.blue, AppColors.blueDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Container(width: 20, height: 3, decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(width: 8),
                  const Text('VOTRE SÉLECTION', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.teal, letterSpacing: 2)),
                ]),
                const SizedBox(height: 10),
                const Text('3 produits\nrecommandés pour vous', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2)),
                const SizedBox(height: 12),
                // Summary chips
                Wrap(spacing: 6, runSpacing: 6, children: [
                  _SummaryChip(label: secteur),
                  _SummaryChip(label: objectif),
                  _SummaryChip(label: budget),
                  _SummaryChip(label: quantite),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text('PRODUITS RECOMMANDÉS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1.5)),
          const SizedBox(height: 14),

          // Product cards
          ...results.asMap().entries.map((entry) => _RecoCard(rank: entry.key + 1, data: entry.value)),

          const SizedBox(height: 24),

          // CTA devis
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.tealLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.teal.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Intéressé par cette sélection ?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.blue)),
                const SizedBox(height: 4),
                const Text('Un conseiller Synneo vous rappelle sous 24h pour affiner votre projet.', style: TextStyle(fontSize: 12, color: AppColors.greyText, height: 1.4)),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final subject = Uri.encodeComponent('Demande de devis — Configurateur Synneo');
                      final body = Uri.encodeComponent(
                        'Secteur : $secteur\nObjectif : $objectif\nBudget : $budget\nQuantité : $quantite\n\n'
                        'Produits recommandés :\n${results.map((r) => '- ${r['name']}').join('\n')}\n\n'
                        'Message :',
                      );
                      final uri = Uri.parse('mailto:commercial@synneo.fr?subject=$subject&body=$body');
                      if (await canLaunchUrl(uri)) launchUrl(uri);
                    },
                    icon: const Icon(Icons.send, size: 16, color: AppColors.blue),
                    label: const Text('Demander un devis', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.blue)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final uri = Uri.parse('https://synneo.fr/15-demandez-un-rdv');
                      if (await canLaunchUrl(uri)) launchUrl(uri);
                    },
                    icon: const Icon(Icons.calendar_month, size: 14),
                    label: const Text('Prendre un RDV'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.blue,
                      side: const BorderSide(color: AppColors.blue, width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Restart
          Center(
            child: GestureDetector(
              onTap: onReset,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, size: 14, color: AppColors.greyText),
                  SizedBox(width: 6),
                  Text('Recommencer', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.greyText)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  final String label;
  const _SummaryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white)),
    );
  }
}

class _RecoCard extends StatelessWidget {
  final int rank;
  final Map<String, dynamic> data;
  const _RecoCard({required this.rank, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(data['url'] as String);
        if (await canLaunchUrl(uri)) launchUrl(uri);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.greyBorder, width: 1.5),
          boxShadow: [BoxShadow(color: AppColors.blue.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            // Rank badge
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: rank == 1 ? AppColors.teal : AppColors.tealLight,
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('0$rank', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: rank == 1 ? AppColors.blue : AppColors.blue))),
            ),
            const SizedBox(width: 14),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['name'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.dark)),
                const SizedBox(height: 3),
                Text(data['desc'] as String, style: const TextStyle(fontSize: 12, color: AppColors.greyText)),
                const SizedBox(height: 6),
                Row(children: [
                  ...List.generate(5, (i) => Icon(
                    i < (data['rse'] as int) ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: AppColors.teal, size: 14,
                  )),
                  const SizedBox(width: 4),
                  const Text('RSE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.greyText)),
                ]),
              ],
            )),
            const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.greyBorder),
          ],
        ),
      ),
    );
  }
}

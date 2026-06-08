import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  static const List<Map<String, dynamic>> solutions = [
    {'icon': FontAwesomeIcons.layerGroup, 'title': 'Gestion de Catalogue', 'desc': 'Optimisez votre catalogue d\'objets média avec une gestion centralisée et efficace.', 'url': 'https://synneo.fr/8-solutions'},
    {'icon': FontAwesomeIcons.peopleGroup, 'title': 'Achats Groupés', 'desc': 'Bénéficiez de tarifs compétitifs grâce à notre système d\'achats groupés.', 'url': 'https://synneo.fr/8-solutions'},
    {'icon': FontAwesomeIcons.print, 'title': 'Print on Demand', 'desc': 'Commandez exactement ce dont vous avez besoin, sans surstock ni gaspillage.', 'url': 'https://synneo.fr/8-solutions'},
    {'icon': FontAwesomeIcons.chartBar, 'title': 'Sondages Internes', 'desc': 'Mesurez l\'impact de vos opérations avec nos outils de sondage intégrés.', 'url': 'https://synneo.fr/8-solutions'},
  ];

  static const List<Map<String, dynamic>> specialisations = [
    {'icon': FontAwesomeIcons.trademark, 'title': 'Licence de Marques', 'desc': 'Produits dérivés sous licence', 'url': 'https://synneo.fr/content/12-licence-de-marques'},
    {'icon': FontAwesomeIcons.bullhorn, 'title': 'Conseil en Objet Média', 'desc': 'Stratégie de communication', 'url': 'https://synneo.fr/content/6-objet-media'},
    {'icon': FontAwesomeIcons.penRuler, 'title': 'Synneo Créations', 'desc': 'Customer Exclusive Design', 'url': 'https://synneo.fr/content/17-synneo-creations'},
    {'icon': FontAwesomeIcons.warehouse, 'title': 'Centre de Logistique', 'desc': '3000m² — Toulouse, Lieusaint, St Ouen', 'url': 'https://synneo.fr/content/11-centre-de-logistique'},
    {'icon': FontAwesomeIcons.globe, 'title': 'Agence Web', 'desc': 'Expertise digitale intégrée', 'url': 'https://synneo.fr/content/13-agence-web'},
    {'icon': FontAwesomeIcons.wineGlass, 'title': 'Vins & Gastronomie', 'desc': 'Conseils d\'experts', 'url': 'https://synneo.fr/content/16-vins-et-gastronomie'},
    {'icon': FontAwesomeIcons.stamp, 'title': 'Atelier de Marquage', 'desc': 'Personnalisation de 95% des objets', 'url': 'https://synneo.fr/content/14-atelier-de-marquage'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.white,
            expandedHeight: 120,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.blue, AppColors.blueDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('NOS EXPERTISES', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.teal, letterSpacing: 2)),
                    const SizedBox(height: 4),
                    const Text('Solutions & Spécialisations', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white)),
                  ],
                ),
              ),
            ),
            title: const Text('Solutions & Services'),
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Text('NOS SOLUTIONS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1.5)),
                ),
                ...solutions.map((s) => _SolutionCard(data: s)),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Text('SPÉCIALISATIONS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1.5)),
                ),
                ...specialisations.map((s) => _SpecTile(data: s)),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SolutionCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const _SolutionCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.greyBorder, width: 1.5),
        boxShadow: [BoxShadow(color: AppColors.blue.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.tealLight, borderRadius: BorderRadius.circular(10)),
            child: FaIcon(data['icon'] as IconData, color: AppColors.blue, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data['title'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.dark)),
                const SizedBox(height: 4),
                Text(data['desc'] as String, style: const TextStyle(fontSize: 12, color: AppColors.greyText, height: 1.4)),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    final uri = Uri.parse(data['url'] as String);
                    if (await canLaunchUrl(uri)) launchUrl(uri);
                  },
                  child: const Text('En savoir plus →', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.teal)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecTile extends StatelessWidget {
  final Map<String, dynamic> data;
  const _SpecTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(data['url'] as String);
        if (await canLaunchUrl(uri)) launchUrl(uri);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: AppColors.greyBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.greyBorder),
        ),
        child: Row(
          children: [
            FaIcon(data['icon'] as IconData, color: AppColors.teal, size: 16),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data['title'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.dark)),
                  Text(data['desc'] as String, style: const TextStyle(fontSize: 11, color: AppColors.greyText)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 11, color: AppColors.greyText),
          ],
        ),
      ),
    );
  }
}

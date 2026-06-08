import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import 'rse_calculator_screen.dart';

class RseScreen extends StatelessWidget {
  const RseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.white,
            title: const Text('RSE & Engagement'),
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Hero
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.blue, AppColors.blueDark],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -30,
                        top: -30,
                        child: Container(width: 140, height: 140,
                          decoration: BoxDecoration(shape: BoxShape.circle,
                            border: Border.all(color: AppColors.teal.withOpacity(0.15), width: 22)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Container(width: 28, height: 3, decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(2))),
                              const SizedBox(width: 8),
                              const Text('NOTRE ENGAGEMENT', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.teal, letterSpacing: 2)),
                            ]),
                            const SizedBox(height: 12),
                            const Text('TRANSFORMER\nL\'OBJET EN MÉDIA\nRESPONSABLE.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1)),
                            const SizedBox(height: 10),
                            Text('Solutions RSE exclusives certifiées pour vos opérations.', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8), height: 1.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Calculateur CTA
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RseCalculatorScreen())),
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.tealLight,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.teal.withOpacity(0.4), width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: AppColors.teal.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.eco, color: AppColors.blue, size: 22),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Calculateur d\'impact RSE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.blue)),
                              SizedBox(height: 2),
                              Text('CO₂, arbres, score — calculez en temps réel', style: TextStyle(fontSize: 12, color: AppColors.greyText)),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.blue),
                      ],
                    ),
                  ),
                ),

                // Certifications
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: Text('CERTIFICATIONS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1.5)),
                ),

                _CertCard(icon: FontAwesomeIcons.certificate, title: 'Bilan Carbone — Bureau Veritas', desc: 'Calcul du bilan carbone certifié Bureau Veritas avec pilotage de la réduction annuelle.'),
                _CertCard(icon: FontAwesomeIcons.chartPie, title: 'Scoring RSE', desc: 'Évaluation auditée par un Cabinet de Conseil RSE indépendant.'),
                _CertCard(
                  icon: FontAwesomeIcons.tree,
                  title: 'ReforestAction',
                  desc: 'Plus de 11 710 arbres plantés ou préservés.',
                  link: 'Voir notre contribution →',
                  url: 'https://www.reforestaction.com/contributeur/Synneo',
                ),

                // Manifeste
                Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 28, height: 3, decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(2))),
                      const SizedBox(height: 12),
                      Text(
                        '"En choisissant un objet média adapté, les entreprises ont l\'opportunité de laisser une empreinte positive et mémorable."',
                        style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.9), fontStyle: FontStyle.italic, height: 1.6),
                      ),
                      const SizedBox(height: 14),
                      GestureDetector(
                        onTap: () async {
                          final uri = Uri.parse('https://synneo.fr/7-rse#manifeste');
                          if (await canLaunchUrl(uri)) launchUrl(uri);
                        },
                        child: const Text('LIRE LE MANIFESTE →', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.teal, letterSpacing: 1)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CertCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final String? link;
  final String? url;

  const _CertCard({required this.icon, required this.title, required this.desc, this.link, this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: url != null ? () async {
        final uri = Uri.parse(url!);
        if (await canLaunchUrl(uri)) launchUrl(uri);
      } : null,
      child: Container(
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
              child: FaIcon(icon, color: AppColors.blue, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.dark)),
                  const SizedBox(height: 4),
                  Text(desc, style: const TextStyle(fontSize: 12, color: AppColors.greyText, height: 1.4)),
                  if (link != null) ...[
                    const SizedBox(height: 6),
                    Text(link!, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.teal)),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

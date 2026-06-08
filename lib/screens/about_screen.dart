import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.white,
            title: const Text('À propos'),
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
                      colors: [AppColors.blue, Color(0xFF036680)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(right: -20, bottom: -20, child: Container(width: 100, height: 100,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.teal.withOpacity(0.15), width: 16)),
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Container(width: 28, height: 3, decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(2))),
                              const SizedBox(width: 8),
                              const Text('L\'AGENCE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.teal, letterSpacing: 2)),
                            ]),
                            const SizedBox(height: 12),
                            const Text('SYNNEO, EXPERT\nDE L\'OBJET MÉDIA\nRESPONSABLE.', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white, height: 1.15)),
                            const SizedBox(height: 10),
                            Text('Nous accompagnons les entreprises avec des solutions durables, technologiques et sur-mesure.', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8), height: 1.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Stats
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('CHIFFRES CLÉS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1.5)),
                      const SizedBox(height: 14),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.6,
                        children: const [
                          _StatCard(value: '3000', unit: 'm²', label: 'Entrepôts logistiques'),
                          _StatCard(value: '95', unit: '%', label: 'Objets personnalisables'),
                          _StatCard(value: '11K', unit: '', label: 'Arbres plantés'),
                          _StatCard(value: '3', unit: '', label: 'Sites logistiques'),
                        ],
                      ),
                    ],
                  ),
                ),

                // International
                GestureDetector(
                  onTap: () async {
                    final uri = Uri.parse('https://synneo.fr/22-international');
                    if (await canLaunchUrl(uri)) launchUrl(uri);
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.tealLight,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.teal.withOpacity(0.3), width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.teal.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                          child: const FaIcon(FontAwesomeIcons.earthEurope, color: AppColors.blue, size: 20)),
                        const SizedBox(width: 14),
                        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Présence internationale', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.blue)),
                          SizedBox(height: 2),
                          Text('Partenaires certifiés à l\'international', style: TextStyle(fontSize: 12, color: AppColors.greyText)),
                        ])),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.blue),
                      ],
                    ),
                  ),
                ),

                // Clients
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                  child: Text('RÉFÉRENCES CLIENTS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1.5)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Thales', 'Airbus', 'Capgemini', 'Safran', 'Michelin', 'CNES', 'Naval Group', 'Carglass'].map((c) =>
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: AppColors.greyBorder, width: 1.5),
                        ),
                        child: Text(c, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.blue)),
                      ),
                    ).toList(),
                  ),
                ),

                // Blog
                GestureDetector(
                  onTap: () async {
                    final uri = Uri.parse('https://blog.synneo.fr');
                    if (await canLaunchUrl(uri)) launchUrl(uri);
                  },
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                          child: const FaIcon(FontAwesomeIcons.newspaper, color: Colors.white, size: 20)),
                        const SizedBox(width: 14),
                        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('Notre Blog', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white)),
                          SizedBox(height: 2),
                          Text('Bonnes pratiques & tendances', style: TextStyle(fontSize: 12, color: Colors.white70)),
                        ])),
                        const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white70),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String unit;
  final String label;
  const _StatCard({required this.value, required this.unit, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.greyBorder, width: 1.5),
        boxShadow: [BoxShadow(color: AppColors.blue.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(text: TextSpan(children: [
            TextSpan(text: value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.blue)),
            TextSpan(text: unit, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.teal)),
          ])),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 10, color: AppColors.greyText, height: 1.3)),
        ],
      ),
    );
  }
}

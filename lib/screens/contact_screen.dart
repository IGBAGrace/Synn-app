import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import 'rdv_screen.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  static const List<Map<String, dynamic>> socialLinks = [
    {'icon': FontAwesomeIcons.linkedin, 'label': 'LinkedIn', 'url': 'https://www.linkedin.com/company/synneogroupe/', 'color': Color(0xFF0077B5)},
    {'icon': FontAwesomeIcons.instagram, 'label': 'Instagram', 'url': 'https://www.instagram.com/synneo.groupe/', 'color': Color(0xFFE1306C)},
    {'icon': FontAwesomeIcons.youtube, 'label': 'YouTube', 'url': 'https://www.youtube.com/channel/UCvZl_prNHUo8Oq9gktwDuOQ', 'color': Color(0xFFFF0000)},
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
            title: const Text('Contact'),
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Hero
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [AppColors.blue, AppColors.blueDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: Stack(
                    children: [
                      Positioned(right: -20, top: -20, child: Container(
                        width: 120, height: 120,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.teal.withOpacity(0.15), width: 20)),
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Container(width: 24, height: 3, decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(2))),
                              const SizedBox(width: 8),
                              const Text('PARLONS DE VOTRE PROJET', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.teal, letterSpacing: 2)),
                            ]),
                            const SizedBox(height: 10),
                            const Text('TRAVAILLONS\nENSEMBLE.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white, height: 1.1)),
                            const SizedBox(height: 8),
                            Text('Vous envisagez une campagne d\'objets média ? Échangeons sur vos attentes.', style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8), height: 1.5)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // RDV primaire — bouton natif
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RdvScreen())),
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: AppColors.teal,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: AppColors.blue.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                            child: const FaIcon(FontAwesomeIcons.calendarCheck, color: AppColors.blue, size: 18),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Demander un RDV', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.blue)),
                              SizedBox(height: 2),
                              Text('Formulaire rapide — réponse sous 24h', style: TextStyle(fontSize: 12, color: AppColors.blueDark)),
                            ],
                          )),
                          const Icon(Icons.arrow_forward_ios, size: 14, color: AppColors.blue),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Autres actions
                _ActionTile(icon: FontAwesomeIcons.envelope, title: 'Nous écrire', desc: 'Envoyez votre demande par email', url: 'https://synneo.fr/23-contact'),
                _ActionTile(icon: FontAwesomeIcons.fileLines, title: 'Démarrer un projet', desc: 'Décrivez votre besoin en détail', url: 'https://content.synneo.fr/projet-objets-media'),
                _ActionTile(icon: FontAwesomeIcons.bookOpen, title: 'Bonnes pratiques', desc: 'Télécharger notre guide RSE', url: 'https://content.synneo.fr/les-bonnes-pratiques-de-communication-par-l-objet-media'),

                const SizedBox(height: 24),

                // Réseaux sociaux
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('RÉSEAUX SOCIAUX', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1.5)),
                      const SizedBox(height: 12),
                      Row(
                        children: socialLinks.map((s) => Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: s == socialLinks.last ? 0 : 10),
                            child: GestureDetector(
                              onTap: () async {
                                final uri = Uri.parse(s['url'] as String);
                                if (await canLaunchUrl(uri)) launchUrl(uri);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.greyBorder, width: 1.5)),
                                child: Column(children: [
                                  FaIcon(s['icon'] as IconData, color: s['color'] as Color, size: 22),
                                  const SizedBox(height: 6),
                                  Text(s['label'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: s['color'] as Color)),
                                ]),
                              ),
                            ),
                          ),
                        )).toList(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Légal
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: AppColors.greyBg, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.greyBorder)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('LÉGAL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1)),
                        const SizedBox(height: 10),
                        ...[
                          ('Mentions légales', 'https://synneo.fr/fr/2-mentions-legales'),
                          ('Politique de confidentialité', 'https://synneo.fr/fr/21-politique-de-confidentialite-et-protection-des-donnees'),
                          ('Politique de cookies', 'https://synneo.fr/fr/34-politique-de-cookies'),
                        ].map((item) => GestureDetector(
                          onTap: () async {
                            final uri = Uri.parse(item.$2);
                            if (await canLaunchUrl(uri)) launchUrl(uri);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              Text(item.$1, style: const TextStyle(fontSize: 13, color: AppColors.greyText)),
                              const Icon(Icons.arrow_forward_ios, size: 10, color: AppColors.greyText),
                            ]),
                          ),
                        )),
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

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final String url;
  const _ActionTile({required this.icon, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) launchUrl(uri);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.greyBorder, width: 1.5),
          boxShadow: [BoxShadow(color: AppColors.blue.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: AppColors.tealLight, borderRadius: BorderRadius.circular(10)),
              child: FaIcon(icon, color: AppColors.blue, size: 16),
            ),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.dark)),
              Text(desc, style: const TextStyle(fontSize: 12, color: AppColors.greyText)),
            ])),
            const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.greyText),
          ],
        ),
      ),
    );
  }
}

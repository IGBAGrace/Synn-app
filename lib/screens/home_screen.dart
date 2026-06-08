import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.white,
            elevation: 0,
            title: Row(
              children: [
                _SynneoLogo(),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: AppColors.blue),
                onPressed: () {},
              ),
              const SizedBox(width: 4),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeroSection(),
                _CertCards(),
                _PolesSection(),
                _ClientsSection(),
                _CtaSection(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SynneoLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Logo icon SVG simplifié
        CustomPaint(
          size: const Size(24, 24),
          painter: _LogoPainter(),
        ),
        const SizedBox(width: 8),
        Text(
          'synneo',
          style: TextStyle(
            fontFamily: 'NunitoSans',
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: AppColors.blue,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}

class _LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final tealPaint = Paint()..color = AppColors.teal;
    final bluePaint = Paint()..color = AppColors.blue;
    final blueDarkPaint = Paint()..color = AppColors.blueDark;

    final path1 = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(0, size.height * 0.4)
      ..lineTo(size.width * 0.5, size.height * 0.55)
      ..lineTo(size.width * 0.85, size.height * 0.25)
      ..close();
    canvas.drawPath(path1, tealPaint);

    final path2 = Path()
      ..moveTo(0, size.height * 0.4)
      ..lineTo(0, size.height)
      ..lineTo(size.width * 0.5, size.height * 0.85)
      ..lineTo(size.width * 0.5, size.height * 0.55)
      ..close();
    canvas.drawPath(path2, bluePaint);

    final path3 = Path()
      ..moveTo(size.width * 0.5, size.height * 0.55)
      ..lineTo(size.width * 0.5, size.height * 0.85)
      ..lineTo(size.width, size.height * 0.6)
      ..lineTo(size.width * 0.85, size.height * 0.25)
      ..close();
    canvas.drawPath(path3, blueDarkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.blue, AppColors.blueDark, Color(0xFF036680)],
        ),
      ),
      child: Stack(
        children: [
          // Cercles décoratifs
          Positioned(
            right: -40,
            top: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.teal.withOpacity(0.15),
                  width: 28,
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.teal.withOpacity(0.1),
                  width: 16,
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Eyebrow
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.teal,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'COMMUNICATION PAR L\'OBJET',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColors.teal,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  'SYNNEO,\nL\'AGENCE EN\nOBJET MÉDIA.',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.1,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: 36,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.teal,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Chaque campagne est unique. Transformez l\'objet en média publicitaire responsable.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final uri = Uri.parse('https://content.synneo.fr/projet-objets-media');
                        if (await canLaunchUrl(uri)) launchUrl(uri);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.teal,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'Commencez la vôtre',
                              style: TextStyle(
                                color: AppColors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: AppColors.blue, size: 14),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white.withOpacity(0.35), width: 1.5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Text(
                        'Nos solutions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CertCards extends StatelessWidget {
  final List<Map<String, dynamic>> certs = const [
    {'icon': FontAwesomeIcons.certificate, 'title': 'Partenaire\nhautement certifié'},
    {'icon': FontAwesomeIcons.seedling, 'title': 'Solutions RSE\ncréées pour vous'},
    {'icon': FontAwesomeIcons.leaf, 'title': 'Produits RSE\ncertifiés'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyBg,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: certs.map((c) => Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: c == certs.first ? 0 : 4,
              right: c == certs.last ? 0 : 4,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.blue.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                FaIcon(c['icon'] as IconData, color: AppColors.teal, size: 22),
                const SizedBox(height: 8),
                Text(
                  c['title'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppColors.blue,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        )).toList(),
      ),
    );
  }
}

class _PolesSection extends StatelessWidget {
  final List<Map<String, dynamic>> poles = const [
    {'num': '01', 'name': 'Licence de Marques', 'badge': 'Exclusif'},
    {'num': '02', 'name': 'Conseil Objet Média', 'badge': null},
    {'num': '03', 'name': 'Synneo Créations', 'badge': 'Design'},
    {'num': '04', 'name': 'Centre Logistique', 'badge': null},
    {'num': '05', 'name': 'Agence Web', 'badge': null},
    {'num': '06', 'name': 'Vins & Gastronomie', 'badge': null},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'NOS PÔLES',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppColors.blue,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'Voir tout →',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.teal,
                ),
              ),
            ],
          ),
        ),
        ...poles.map((p) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.greyLight),
            ),
          ),
          child: Row(
            children: [
              Text(
                p['num'] as String,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: AppColors.teal,
                  fontFamily: 'Nunito',
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  p['name'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.dark,
                  ),
                ),
              ),
              if (p['badge'] != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.tealLight,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    p['badge'] as String,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: AppColors.blue,
                    ),
                  ),
                )
              else
                const Icon(Icons.arrow_forward_ios, size: 12, color: AppColors.greyBorder),
            ],
          ),
        )),
      ],
    );
  }
}

class _ClientsSection extends StatelessWidget {
  final List<String> clients = const [
    'Thales', 'Airbus', 'Capgemini', 'Safran', 'Michelin', 'CNES',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Text(
            'ILS NOUS FONT CONFIANCE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppColors.blue,
              letterSpacing: 1.5,
            ),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: clients.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyBorder, width: 1.5),
                borderRadius: BorderRadius.circular(100),
                color: AppColors.white,
              ),
              child: Text(
                clients[i],
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blue,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _CtaSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.blue, AppColors.blueDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.teal.withOpacity(0.2),
                  width: 12,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'VOTRE PROJET',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w800,
                  color: AppColors.teal,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Prêt à lancer\nvotre campagne ?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final uri = Uri.parse('https://synneo.fr/15-demandez-un-rdv');
                  if (await canLaunchUrl(uri)) launchUrl(uri);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.teal,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Demander un RDV',
                        style: TextStyle(
                          color: AppColors.blue,
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, color: AppColors.blue, size: 14),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

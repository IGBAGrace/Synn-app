import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';

class RdvScreen extends StatefulWidget {
  const RdvScreen({super.key});

  @override
  State<RdvScreen> createState() => _RdvScreenState();
}

class _RdvScreenState extends State<RdvScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _societeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telController = TextEditingController();

  String? _motif;
  String? _disponibilite;
  String? _delai;
  final _messageController = TextEditingController();
  bool _sent = false;

  static const List<Map<String, dynamic>> _motifs = [
    {'label': 'Nouveau projet', 'icon': FontAwesomeIcons.wandMagicSparkles},
    {'label': 'Demande de devis', 'icon': FontAwesomeIcons.fileInvoice},
    {'label': 'Suivi de commande', 'icon': FontAwesomeIcons.boxOpen},
    {'label': 'Partenariat', 'icon': FontAwesomeIcons.handshake},
    {'label': 'Question RSE', 'icon': FontAwesomeIcons.leaf},
    {'label': 'Autre', 'icon': FontAwesomeIcons.circleQuestion},
  ];

  static const List<Map<String, dynamic>> _disponibilites = [
    {'label': 'Matin (9h — 12h)', 'icon': FontAwesomeIcons.sun},
    {'label': 'Après-midi (14h — 18h)', 'icon': FontAwesomeIcons.cloudSun},
    {'label': 'Les deux', 'icon': FontAwesomeIcons.clock},
  ];

  static const List<Map<String, dynamic>> _delais = [
    {'label': 'Dès que possible', 'icon': FontAwesomeIcons.bolt},
    {'label': 'Cette semaine', 'icon': FontAwesomeIcons.calendarWeek},
    {'label': 'Ce mois-ci', 'icon': FontAwesomeIcons.calendarDays},
    {'label': 'Sans urgence', 'icon': FontAwesomeIcons.calendar},
  ];

  @override
  void dispose() {
    _nomController.dispose();
    _societeController.dispose();
    _emailController.dispose();
    _telController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      if (_motif == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Veuillez choisir un motif'),
            backgroundColor: AppColors.blue,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
        return;
      }
      HapticFeedback.mediumImpact();

      final subject = Uri.encodeComponent('Demande de RDV — Synneo App');
      final body = Uri.encodeComponent(
        'Nom : ${_nomController.text}\n'
        'Société : ${_societeController.text}\n'
        'Email : ${_emailController.text}\n'
        'Téléphone : ${_telController.text}\n'
        'Motif : $_motif\n'
        'Disponibilité : ${_disponibilite ?? 'Non précisée'}\n'
        'Délai souhaité : ${_delai ?? 'Non précisé'}\n'
        'Message : ${_messageController.text}',
      );
      final uri = Uri.parse('mailto:commercial@synneo.fr?subject=$subject&body=$body');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
        setState(() => _sent = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: _sent ? _SuccessView(onReset: () => setState(() {
        _sent = false;
        _nomController.clear();
        _societeController.clear();
        _emailController.clear();
        _telController.clear();
        _messageController.clear();
        _motif = null;
        _disponibilite = null;
        _delai = null;
      })) : CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.white,
            title: const Text('Demander un RDV'),
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
                      Positioned(right: -20, top: -20, child: Container(
                        width: 110, height: 110,
                        decoration: BoxDecoration(shape: BoxShape.circle,
                          border: Border.all(color: AppColors.teal.withOpacity(0.15), width: 18)),
                      )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 24, 24, 26),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Container(width: 24, height: 3, decoration: BoxDecoration(color: AppColors.teal, borderRadius: BorderRadius.circular(2))),
                              const SizedBox(width: 8),
                              const Text('PARLONS DE VOTRE PROJET', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, color: AppColors.teal, letterSpacing: 2)),
                            ]),
                            const SizedBox(height: 10),
                            const Text('Demandez\nun rendez-vous.', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white, height: 1.2)),
                            const SizedBox(height: 8),
                            Text('Remplissez ce formulaire et un conseiller Synneo vous contactera sous 24h.', style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8), height: 1.5)),
                            const SizedBox(height: 16),
                            // Info chips
                            Row(children: [
                              _InfoChip(icon: FontAwesomeIcons.clock, label: 'Réponse < 24h'),
                              const SizedBox(width: 8),
                              _InfoChip(icon: FontAwesomeIcons.userTie, label: '35 experts en France'),
                            ]),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Form
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // Section 1 — Coordonnées
                        _SectionLabel(label: 'VOS COORDONNÉES', icon: FontAwesomeIcons.user),
                        const SizedBox(height: 12),
                        _FormField(controller: _nomController, label: 'Nom & prénom *', icon: Icons.person_outline,
                          validator: (v) => v!.isEmpty ? 'Champ requis' : null),
                        const SizedBox(height: 10),
                        _FormField(controller: _societeController, label: 'Société *', icon: Icons.business_outlined,
                          validator: (v) => v!.isEmpty ? 'Champ requis' : null),
                        const SizedBox(height: 10),
                        _FormField(controller: _emailController, label: 'Email professionnel *', icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) => v!.isEmpty || !v.contains('@') ? 'Email invalide' : null),
                        const SizedBox(height: 10),
                        _FormField(controller: _telController, label: 'Téléphone *', icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (v) => v!.isEmpty ? 'Champ requis' : null),

                        const SizedBox(height: 24),

                        // Section 2 — Motif
                        _SectionLabel(label: 'MOTIF DU RDV', icon: FontAwesomeIcons.clipboardList),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _motifs.map((m) {
                            final isSelected = _motif == m['label'];
                            return GestureDetector(
                              onTap: () { HapticFeedback.selectionClick(); setState(() => _motif = m['label'] as String); },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.blue : AppColors.white,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: isSelected ? AppColors.blue : AppColors.greyBorder, width: 1.5),
                                ),
                                child: Row(mainAxisSize: MainAxisSize.min, children: [
                                  FaIcon(m['icon'] as IconData, size: 11, color: isSelected ? AppColors.teal : AppColors.greyText),
                                  const SizedBox(width: 6),
                                  Text(m['label'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: isSelected ? Colors.white : AppColors.dark)),
                                ]),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 24),

                        // Section 3 — Disponibilités
                        _SectionLabel(label: 'VOS DISPONIBILITÉS', icon: FontAwesomeIcons.clock),
                        const SizedBox(height: 12),
                        Row(children: _disponibilites.map((d) {
                          final isSelected = _disponibilite == d['label'];
                          return Expanded(
                            child: GestureDetector(
                              onTap: () { HapticFeedback.selectionClick(); setState(() => _disponibilite = d['label'] as String); },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                margin: EdgeInsets.only(right: d == _disponibilites.last ? 0 : 8),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.blue : AppColors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: isSelected ? AppColors.blue : AppColors.greyBorder, width: 1.5),
                                ),
                                child: Column(children: [
                                  FaIcon(d['icon'] as IconData, size: 14, color: isSelected ? AppColors.teal : AppColors.greyText),
                                  const SizedBox(height: 5),
                                  Text(d['label'] as String, textAlign: TextAlign.center, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: isSelected ? Colors.white : AppColors.dark)),
                                ]),
                              ),
                            ),
                          );
                        }).toList()),

                        const SizedBox(height: 24),

                        // Section 4 — Délai
                        _SectionLabel(label: 'DÉLAI SOUHAITÉ', icon: FontAwesomeIcons.calendarCheck),
                        const SizedBox(height: 12),
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 2.8,
                          children: _delais.map((d) {
                            final isSelected = _delai == d['label'];
                            return GestureDetector(
                              onTap: () { HapticFeedback.selectionClick(); setState(() => _delai = d['label'] as String); },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.blue : AppColors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: isSelected ? AppColors.blue : AppColors.greyBorder, width: 1.5),
                                ),
                                child: Row(children: [
                                  FaIcon(d['icon'] as IconData, size: 12, color: isSelected ? AppColors.teal : AppColors.greyText),
                                  const SizedBox(width: 8),
                                  Expanded(child: Text(d['label'] as String, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: isSelected ? Colors.white : AppColors.dark))),
                                ]),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 24),

                        // Section 5 — Message
                        _SectionLabel(label: 'VOTRE MESSAGE', icon: FontAwesomeIcons.message),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _messageController,
                          maxLines: 4,
                          style: const TextStyle(fontSize: 13, color: AppColors.dark),
                          decoration: InputDecoration(
                            hintText: 'Décrivez votre projet, vos besoins, vos questions...',
                            hintStyle: const TextStyle(color: AppColors.greyText, fontSize: 13),
                            alignLabelWithHint: true,
                            filled: true,
                            fillColor: AppColors.greyBg,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.greyBorder)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.greyBorder)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: AppColors.blue, width: 2)),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Submit
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _submit,
                            icon: const Icon(Icons.send, size: 16, color: AppColors.blue),
                            label: const Text('Envoyer ma demande', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: AppColors.blue)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.teal,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Alternative — lien direct
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              final uri = Uri.parse('https://synneo.fr/15-demandez-un-rdv');
                              if (await canLaunchUrl(uri)) launchUrl(uri);
                            },
                            icon: const Icon(Icons.open_in_new, size: 14),
                            label: const Text('Via le site synneo.fr'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.blue,
                              side: const BorderSide(color: AppColors.greyBorder, width: 1.5),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
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

// ── WIDGETS ───────────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.white.withOpacity(0.25)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        FaIcon(icon, size: 10, color: AppColors.teal),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white)),
      ]),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  const _SectionLabel({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(color: AppColors.tealLight, borderRadius: BorderRadius.circular(8)),
        child: FaIcon(icon, size: 12, color: AppColors.blue),
      ),
      const SizedBox(width: 10),
      Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppColors.blue, letterSpacing: 1.5)),
    ]);
  }
}

class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _FormField({required this.controller, required this.label, required this.icon, this.keyboardType, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(fontSize: 13, color: AppColors.dark),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.greyText, fontSize: 13),
        prefixIcon: Icon(icon, color: AppColors.greyText, size: 18),
        filled: true,
        fillColor: AppColors.greyBg,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.greyBorder)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.greyBorder)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.blue, width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Colors.red)),
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final VoidCallback onReset;
  const _SuccessView({required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90, height: 90,
              decoration: const BoxDecoration(color: AppColors.tealLight, shape: BoxShape.circle),
              child: const Icon(Icons.check_circle, color: AppColors.teal, size: 50),
            ),
            const SizedBox(height: 24),
            const Text('Demande envoyée !', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.blue)),
            const SizedBox(height: 12),
            const Text(
              'Un conseiller Synneo vous contactera sous 24h pour organiser votre rendez-vous.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: AppColors.greyText, height: 1.6),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: onReset,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.teal,
                foregroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              ),
              child: const Text('Nouvelle demande', style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ],
        ),
      ),
    );
  }
}

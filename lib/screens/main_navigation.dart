import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'catalogue_screen.dart';
import 'configurateur_screen.dart';
import 'rse_screen.dart';
import 'contact_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    CatalogueScreen(),
    ConfigurateurScreen(),
    RseScreen(),
    ContactScreen(),
  ];

  final List<Map<String, dynamic>> _navItems = const [
    {'icon': FontAwesomeIcons.house, 'label': 'Accueil'},
    {'icon': FontAwesomeIcons.layerGroup, 'label': 'Catalogue'},
    {'icon': FontAwesomeIcons.wandMagicSparkles, 'label': 'Projet'},
    {'icon': FontAwesomeIcons.shieldHalved, 'label': 'RSE'},
    {'icon': FontAwesomeIcons.envelope, 'label': 'Contact'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: const Border(top: BorderSide(color: AppColors.greyBorder)),
          boxShadow: [
            BoxShadow(color: AppColors.blue.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, -4)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (i) {
                final isActive = i == _currentIndex;
                return GestureDetector(
                  onTap: () => setState(() => _currentIndex = i),
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 4, height: 4,
                        margin: const EdgeInsets.only(bottom: 4),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: isActive ? AppColors.teal : Colors.transparent),
                      ),
                      FaIcon(_navItems[i]['icon'] as IconData, size: 18, color: isActive ? AppColors.blue : AppColors.greyText),
                      const SizedBox(height: 4),
                      Text(_navItems[i]['label'] as String, style: TextStyle(fontSize: 9, fontWeight: isActive ? FontWeight.w800 : FontWeight.w500, color: isActive ? AppColors.blue : AppColors.greyText)),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

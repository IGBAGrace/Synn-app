import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ClientLogoStrip extends StatelessWidget {
  const ClientLogoStrip({super.key});

  static const List<String> clients = [
    'Thales', 'Airbus', 'Capgemini', 'Safran',
    'Carglass', 'Michelin', 'CNES', 'Naval Group',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: clients.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.greyBorder, width: 1.5),
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
    );
  }
}

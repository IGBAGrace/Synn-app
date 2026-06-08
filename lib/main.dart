import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/main_navigation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const SynneoApp());
}

class SynneoApp extends StatelessWidget {
  const SynneoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Synneo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const MainNavigation(),
    );
  }
}

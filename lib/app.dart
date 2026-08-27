import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/auth/auth_gate.dart';

class LifeBookApp extends StatelessWidget {
  const LifeBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeBook Beta',
      debugShowCheckedModeBanner: false,
      theme: lifeBookLightTheme,
      darkTheme: lifeBookDarkTheme,
      themeMode: ThemeMode.dark,
      home: const AuthGate(),
    );
  }
}

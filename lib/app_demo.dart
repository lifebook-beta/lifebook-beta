import 'package:flutter/material.dart';
import 'screens/auth/auth_gate.dart';
import 'core/theme.dart';

class LifeBookDemoApp extends StatelessWidget {
  const LifeBookDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeBook Beta',
      debugShowCheckedModeBanner: false,
      theme: lifeBookDarkTheme,
      home: const AuthGate(),
    );
  }
}

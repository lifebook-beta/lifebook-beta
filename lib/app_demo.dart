import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/shell/home_shell.dart';

class LifeBookDemoApp extends StatelessWidget {
  const LifeBookDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifeBook Beta',
      debugShowCheckedModeBanner: false,
      theme: lifeBookDarkTheme,
      home: const DemoHome(),
    );
  }
}

class DemoHome extends StatelessWidget {
  const DemoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeShell();
  }
}

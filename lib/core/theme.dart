import 'package:flutter/material.dart';

const lbNavy = Color(0xFF071321);
const lbSurface = Color(0xFF102238);
const lbBlue = Color(0xFF1976F3);
const lbText = Color(0xFFF4F7FB);
const lbMuted = Color(0xFF9AA9BB);

ThemeData _theme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  return ThemeData(
    brightness: brightness,
    scaffoldBackgroundColor: dark ? lbNavy : const Color(0xFFF5F7FA),
    colorScheme: ColorScheme.fromSeed(
      seedColor: lbBlue,
      brightness: brightness,
      surface: dark ? lbSurface : Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: dark ? lbNavy : Colors.white,
      foregroundColor: dark ? lbText : Colors.black87,
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: dark ? lbSurface : Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
    cardTheme: CardThemeData(
      color: dark ? lbSurface : Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}

final lifeBookDarkTheme = _theme(Brightness.dark);
final lifeBookLightTheme = _theme(Brightness.light);

class LBLogo extends StatelessWidget {
  final double size;
  const LBLogo({super.key, this.size = 58});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * .25),
        border: Border.all(color: Colors.white70),
        color: lbSurface,
      ),
      child: Text(
        'LB',
        style: TextStyle(
          color: Colors.white,
          fontSize: size * .36,
          fontWeight: FontWeight.w700,
          letterSpacing: -1,
        ),
      ),
    );
  }
}

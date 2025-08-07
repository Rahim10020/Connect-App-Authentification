import 'package:connect_app/core/constants/app_fonts.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  // Familles de police
  // static const String _kanitFontFamily = AppFonts.kanit;
  static const String _robotoFontFamily = AppFonts.roboto;

  // heading
  static const TextStyle heading1 = TextStyle(
    fontFamily: _robotoFontFamily,
    fontSize: 32,
    height: 2.286,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: _robotoFontFamily,
    fontSize: 28,
    height: 2.000,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: _robotoFontFamily,
    fontSize: 25,
    height: 1.786,
  );

  // body
  static const TextStyle body1 = TextStyle(
    fontFamily: _robotoFontFamily,
    fontSize: 22,
    height: 1.571,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: _robotoFontFamily,
    fontSize: 20,
    height: 1.429,
  );

  static const TextStyle body3 = TextStyle(
    fontFamily: _robotoFontFamily,
    fontSize: 18,
    height: 1.286,
  );

  // caption
  static const TextStyle caption1 = TextStyle(
    fontFamily: _robotoFontFamily,
    fontSize: 16,
    height: 1.143,
  );

  static const TextStyle caption2 = TextStyle(
    fontFamily: _robotoFontFamily,
    fontSize: 14,
    height: 1.000,
  );

  // small
  static const TextStyle small1 = TextStyle(
    fontFamily: _robotoFontFamily,
    fontSize: 12,
    height: 0.857,
  );

  static const TextStyle small2 = TextStyle(
    fontFamily: _robotoFontFamily,
    fontSize: 11,
    height: 0.786,
  );
}

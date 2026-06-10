import 'package:flutter/material.dart';

class AppColors {

  static const authHeroStart = Color(0xFF1565C0);
  static const authHeroMid   = Color(0xFF0D47A1);
  static const authHeroEnd   = Color(0xFF051F5C);

  static const LinearGradient authHeroGradient = LinearGradient(
    colors: [authHeroStart, authHeroMid, authHeroEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );


  static const heroText        = Color(0xFFFFFFFF); // logo icon, heading
  static const heroSubtext     = Color(0xA6FFFFFF); // subtitle — 65% white
  static const heroLogoOverlay = Color(0x2DFFFFFF); // logo box bg — 18% white
  static const heroLogoBorder  = Color(0x4DFFFFFF); // logo box border — 30% white
  static const heroDecorColor  = Color(0x12FFFFFF); // cross svg — 7% white
  static const heroDecorColor2 = Color(0x0DFFFFFF); // circles svg — 5% white

  static const primary      = Color(0xFF1565C0); // login button, links
  static const primaryMid   = Color(0xFF90CAF9); // disabled button
  static const border       = Color(0xFFD0E2F5); // textfield border
  static const error        = Color(0xFFC62828); // validation errors


  static const textPrimary   = Color(0xFF0D1B2A); // labels, headings
  static const textSecondary = Color(0xFF8AA0B8); // subtitles, links
  static const textHint      = Color(0xFF8AA0B8); // textfield hints


  static const surface = Color(0xFFF5F9FF); // screen background
  static const white   = Color(0xFFFFFFFF); // card, textfield bg
  static const bgLight = Color(0xFFECF2FB); // section backgrounds
}
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {

  /// Font families
  static const String spaceGrotesk = 'SpaceGrotesk';
  static const String inter = 'Inter';
  static const String jetBrainsMono = 'JetBrainsMono';

  static TextStyle get testStyle => const TextStyle(
    color: Colors.white
  );


  /// Nav bar style
  static TextStyle get navBarAppTitle => const TextStyle(
    color: AppColors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: spaceGrotesk
  );
  static TextStyle get navBarItemStyle => const TextStyle(
      color: AppColors.primaryColor,
      fontSize: 14,
      fontWeight: .w500,
      fontFamily: jetBrainsMono
  );
  static TextStyle get resumeButton => const TextStyle(
      color: AppColors.textSecondary,
      fontWeight: .w800,
      fontFamily: jetBrainsMono
  );

  static TextStyle get availableStyle => const TextStyle(
    color: Colors.white,
    fontWeight: .w400,
    fontSize: 10,
    fontFamily: jetBrainsMono
  );

  static TextStyle get greetingStyle => const TextStyle(
      color: Colors.white,
      fontWeight: .w700,
      fontSize: 62,
      fontFamily: 'SpaceGrotesk'
  );

  static TextStyle get roleStyle => const TextStyle(
    color: AppColors.primaryColor,
    fontWeight: .bold,
    fontSize: 32,
    fontFamily: spaceGrotesk
  );

  static TextStyle get descriptionStyle => const TextStyle(
      color: Colors.white70,
      fontWeight: .w500,
      fontSize: 22,
      fontFamily: 'Inter'
  );

  static TextStyle get viewProjectsStyle => const TextStyle(
    color: AppColors.textSecondary,
    fontWeight: .w300
  );

  static TextStyle get gitHubStyle => const TextStyle(
    color: Colors.white,
    fontWeight: .w300,
    fontFamily: jetBrainsMono
  );

  /// Hero section
  static TextStyle get badgeStyle => const TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontFamily: jetBrainsMono
  );


  /// About section
  static TextStyle get aboutMeStyle => const TextStyle(
    color: AppColors.primaryColor,
    fontWeight: .w500,
    fontSize: 16,
    fontFamily: jetBrainsMono
  );
  static TextStyle get aboutPrecisionStyle => TextStyle(
    color: Colors.white.withAlpha(225),
    fontWeight: .w700,
    fontSize: 30,
    fontFamily: spaceGrotesk
  );
  static TextStyle get aboutDescriptionStyle => TextStyle(
    color: Colors.white.withAlpha(215),
    fontWeight: .w400,
    fontSize: 20,
    fontFamily: inter
  );
  static TextStyle get aboutContainerTitleStyle => const TextStyle(
    color: AppColors.primaryColor,
    fontWeight: .w700,
    fontSize: 24,
    fontFamily: spaceGrotesk
  );
  static TextStyle get aboutContainerSubTitleStyle => const TextStyle(
      color: Colors.white70,
      fontWeight: .w600,
      fontSize: 16,
      fontFamily: jetBrainsMono
  );

   /// Skill section
  static TextStyle get skillLabelStyle => const TextStyle(
    color: Colors.white70,
    fontWeight: .w700,
    fontSize: 26,
    fontFamily: spaceGrotesk
  );
  static TextStyle get subSkillStyle => const TextStyle(
      color: Colors.white70,
      fontWeight: .w600,
      fontSize: 16,
      fontFamily: jetBrainsMono
  );

  /// Project Section
  static TextStyle get projectOneTitle => const TextStyle(
    color: Colors.white,
    fontWeight: .w700,
    fontSize: 20,
    fontFamily: spaceGrotesk
  );
  static TextStyle get projectOneDescription => const TextStyle(
    color: Colors.white70,
    fontWeight: .w500,
    fontSize: 16,
    fontFamily: inter
  );
  static TextStyle get projectOneTag => const TextStyle(
      color: AppColors.primaryColor,
      fontWeight: .w300,
      fontSize: 14,
      fontFamily: jetBrainsMono
  );
  static TextStyle get projectOneButton => const TextStyle(
    color: AppColors.textSecondary,
    fontWeight: .w800,
    fontSize: 16,
    fontFamily: jetBrainsMono
  );

  /// Contact Section
  static TextStyle get contactTitle => const TextStyle(
      color: Colors.white70,
      fontWeight: .w800,
      fontSize: 20,
      fontFamily: spaceGrotesk
  );
  static TextStyle get contactDescription => const TextStyle(
      color: Colors.white54,
      fontWeight: .w600,
      fontSize: 16,
      fontFamily: jetBrainsMono
  );
  static TextStyle get finalTitle => const TextStyle(
    color: Colors.white,
    fontWeight: .w400,
    fontSize: 16,
    fontFamily: inter
  );
  static TextStyle get finalDescription => const TextStyle(
      color: Colors.white70,
      fontWeight: .w500,
      fontSize: 14,
      fontFamily: jetBrainsMono
  );


}
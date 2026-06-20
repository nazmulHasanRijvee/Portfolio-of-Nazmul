import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {

  static TextStyle get testStyle => TextStyle(
    color: Colors.white
  );

  static TextStyle get availableStyle => TextStyle(
    color: Colors.white,
    fontWeight: .bold,
    fontSize: 12
  );

  static TextStyle get greetingStyle => TextStyle(
      color: Colors.white,
      fontWeight: .w700,
      fontSize: 62
  );

  static TextStyle get roleStyle => TextStyle(
    color: AppColors.primaryColor,
    fontWeight: .bold,
    fontSize: 32
  );

  static TextStyle get descriptionStyle => TextStyle(
      color: Colors.white,
      fontWeight: .w500,
      fontSize: 22
  );

  static TextStyle get resumeButton => TextStyle(
    color: AppColors.textSecondary,
    fontWeight: .bold
  );

  static TextStyle get viewProjectsStyle => TextStyle(
    color: AppColors.textSecondary,
    fontWeight: .w300
  );

  static TextStyle get gitHubStyle => TextStyle(
    color: Colors.white,
    fontWeight: .w300,
  );

  /// Hero section
  static TextStyle get badgeStyle => TextStyle(
    color: Colors.white,
    fontSize: 12
  );


  /// About section
  static TextStyle get aboutMeStyle => TextStyle(
    color: AppColors.primaryColor,
    fontWeight: .w600,
    fontSize: 16
  );
  static TextStyle get aboutPrecisionStyle => TextStyle(
    color: Colors.white,
    fontWeight: .w700,
    fontSize: 30
  );
  static TextStyle get aboutDescriptionStyle => TextStyle(
    color: Colors.white70,
    fontWeight: .w400,
    fontSize: 20
  );
  static TextStyle get aboutContainerTitleStyle => TextStyle(
    color: AppColors.primaryColor,
    fontWeight: .w700,
    fontSize: 24
  );
  static TextStyle get aboutContainerSubTitleStyle => TextStyle(
      color: Colors.white70,
      fontWeight: .w600,
      fontSize: 16
  );

   /// Skill section
  static TextStyle get skillLabelStyle => TextStyle(
    color: Colors.white70,
    fontWeight: .w700,
    fontSize: 26
  );
  static TextStyle get subSkillStyle => TextStyle(
      color: Colors.white70,
      fontWeight: .w600,
      fontSize: 16
  );

  /// Project Section
  static TextStyle get projectOneTitle => TextStyle(
    color: Colors.white,
    fontWeight: .w700,
    fontSize: 20
  );
  static TextStyle get projectOneDescription => TextStyle(
    color: Colors.white70,
    fontWeight: .w500,
    fontSize: 16
  );
  static TextStyle get projectOneTag => TextStyle(
      color: AppColors.primaryColor,
      fontWeight: .w300,
      fontSize: 14
  );
  static TextStyle get projectOneButton => TextStyle(
    color: AppColors.textSecondary,
    fontWeight: .w900,
    fontSize: 16,

  );

  /// Contact Section
  static TextStyle get contactTitle => TextStyle(
      color: Colors.white70,
      fontWeight: .w800,
      fontSize: 20
  );
  static TextStyle get contactDescription => TextStyle(
      color: Colors.white54,
      fontWeight: .w600,
      fontSize: 16
  );
  static TextStyle get finalTitle => TextStyle(
    color: Colors.white,
    fontWeight: .w600,
    fontSize: 16
  );
  static TextStyle get finalDescription => TextStyle(
      color: Colors.white70,
      fontWeight: .w500,
      fontSize: 14
  );


}
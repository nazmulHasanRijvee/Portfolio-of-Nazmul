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

}
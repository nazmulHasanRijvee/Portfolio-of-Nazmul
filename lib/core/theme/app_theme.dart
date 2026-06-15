import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppTheme {

  static ThemeData get theme => ThemeData(

    scaffoldBackgroundColor: AppColors.background,
    colorSchemeSeed: AppColors.primaryColor

  );

}
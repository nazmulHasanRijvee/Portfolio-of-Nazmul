import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class SectionHeader extends StatelessWidget {

  final double ratio;
  final bool isMobile;

  const SectionHeader({super.key, required this.ratio, required this.isMobile});

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: .start,
      children: [
        Text(
          AppStrings.aboutMe,
          style: AppTextStyles.aboutMeStyle
              .copyWith(fontSize: isMobile ? 20 * ratio : 16 * ratio),
        ),
        const SizedBox(height: 10),
        Text(
          AppStrings.aboutPrecision,
          style: AppTextStyles.aboutPrecisionStyle
              .copyWith(fontSize: isMobile ? 34 * ratio : 30 * ratio),
        ),
      ],
    );

  }
}

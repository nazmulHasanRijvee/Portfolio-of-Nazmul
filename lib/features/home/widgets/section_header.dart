import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class SectionHeader extends StatelessWidget {

  final double ratio;
  final bool isMobile;
  final String? sectionNumber;
  final String? sectionTitle;
  final bool isContactSection;

  const SectionHeader({
    super.key,
    required this.ratio,
    this.isMobile = false,
    this.sectionNumber,
    this.sectionTitle,
    this.isContactSection = false,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isContactSection ? .center : .start,
      children: [
        Text(
          sectionNumber ?? AppStrings.aboutMe,
          style: AppTextStyles.aboutMeStyle
              .copyWith(fontSize: (isMobile ? 20 : 16) * ratio),
        ),
        const SizedBox(height: 10),
        Text(
          sectionTitle ?? AppStrings.aboutPrecision,
          style: AppTextStyles.aboutPrecisionStyle
              .copyWith(fontSize: (isMobile ? 34 : 30) * ratio),
        ),
      ],
    );

  }
}

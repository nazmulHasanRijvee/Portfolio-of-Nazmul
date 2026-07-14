import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/url_launcher.dart';
import '../../../data/services/firebase_analytics_service.dart';

class ResumeButton extends StatelessWidget {

  final double ratio;
  final bool isTablet;

  const ResumeButton({
    super.key,
    this.ratio = 1,
    this.isTablet = false
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: openResume,
      style: FilledButton.styleFrom(
        padding: isTablet?
        EdgeInsets.symmetric(vertical: 10 * ratio, horizontal: 10 * ratio) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: AppColors.filledButtonColor,
      ),
      child: Text(
        AppStrings.downloadResume,
        style: AppTextStyles.resumeButton
            .copyWith(fontSize: isTablet? 16 * (ratio / 1.1) : null), /// needs work nav items are much larger for tablet
      ),
    );
  }

  void openResume() {
    // debugPrint('Resume button pressed ${context.sizeOf.width}');
    UrlLauncher.openResume();
    final analytics = AnalyticsService();
    analytics.logResumeClicked();
  }
}

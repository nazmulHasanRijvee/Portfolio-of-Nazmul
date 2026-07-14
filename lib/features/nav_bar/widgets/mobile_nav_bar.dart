import 'package:flutter/material.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/media_query_extension.dart';
import '../../../core/utils/url_launcher.dart';
import '../../../data/services/firebase_analytics_service.dart';

class MobileNavBar extends StatefulWidget {

  final Function(GlobalKey, String) onNavTap;
  final Map<String, GlobalKey> keys;


  const MobileNavBar({super.key, required this.onNavTap, required this.keys});

  @override
  State<MobileNavBar> createState() => _MobileNavBarState();
}

class _MobileNavBarState extends State<MobileNavBar> {

  @override
  Widget build(BuildContext context) {

    final double ratio = (context.sizeOf.width / AppBreakpoints.mobile).clamp(0.1, 1.0);
    final double secondRatio = (context.sizeOf.width / (AppBreakpoints.mobile * 0.7))
        .clamp(0.1, 1.0);

    return Container(
      height: 80 * ratio,
      padding: EdgeInsets.symmetric(horizontal: 38 * ratio,),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),

      child: Row(
        mainAxisAlignment: .center,
        children: [
          Text(
            AppStrings.appTitle,
            style: AppTextStyles.navBarAppTitle
                .copyWith(fontSize: 24 * secondRatio)
          ),

          const Spacer(),

          // Resume button
          FilledButton(
            onPressed: openResume,
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15 * ratio, horizontal: 40 * ratio),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: AppColors.filledButtonColor,
            ),
            child: Text(
                AppStrings.downloadResume,
                style: AppTextStyles.resumeButton.copyWith(fontSize: 24 * ratio, fontWeight: .w700)
            ),
          ),
        ],
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

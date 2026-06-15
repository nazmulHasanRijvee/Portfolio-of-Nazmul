import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/constants/app_breakpoints.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/media_query_extension.dart';

class MobileNavBar extends StatefulWidget {

  final ValueChanged<GlobalKey> onNavTap;
  final Map<String, GlobalKey> keys;


  const MobileNavBar({super.key, required this.onNavTap, required this.keys});

  @override
  State<MobileNavBar> createState() => _MobileNavBarState();
}

class _MobileNavBarState extends State<MobileNavBar> {

  @override
  Widget build(BuildContext context) {

    final double ratio = context.sizeOf.width / AppBreakpoints.mobile;
    final double secondRatio = context.sizeOf.width / (AppBreakpoints.mobile * 0.7);

    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 38 * ratio),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 0.5),
        ),
      ),

      child: Row(
        mainAxisAlignment: .center,
        children: [
          // Logo
          Text(
            'NazmulDev',
            style: TextStyle(
              color: AppColors.white,
              fontSize: (24 * secondRatio).clamp(11, 24),
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),


          // Resume button
          FilledButton(
            onPressed: () {
              debugPrint('Resume button pressed ${context.sizeOf.width}');
            }, // url_launcher later
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15 * ratio, horizontal: 40 * ratio),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: AppColors.filledButtonColor,
            ),
            child: Text(
                'Download Resume',
                style: AppTextStyles.resumeButton.copyWith(fontSize: 24 * ratio, fontWeight: .w700)
            ),
          ),
        ],
      ),

    );

  }

}

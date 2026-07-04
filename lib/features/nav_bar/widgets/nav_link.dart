import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/constants/app_text_styles.dart';

import '../../../core/constants/app_colors.dart';

class NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;
  final double ratio;
  final double secondRatio;

  const NavLink({
    super.key,
    required this.label,
    required this.onTap,
    required this.isSelected,
    this.secondRatio = 1.0, // Default values are given if already not specified
    this.ratio = 1.0
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16 * ratio),
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(
              label,
              style: AppTextStyles.navBarItemStyle
                  .copyWith(fontSize: 14 * secondRatio)
            ),
            const SizedBox(height: 5),
            if(isSelected)
              Container(
                height: 3,
                width: getWidth(label.length, secondRatio) , // 35
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              )
          ],
        ),
      ),
    );
  }

  double getWidth(int labelLength, double ratio){

    switch(labelLength){

      case 4:
        return 35 * ratio;
      case 5:
        return 40 * ratio;
      case 6:
        return 38 * ratio;
      case 7:
        return 50 * ratio;
      case 8:
        return 54 * ratio;
      default:
        return 35 * ratio;
    }

  }
}
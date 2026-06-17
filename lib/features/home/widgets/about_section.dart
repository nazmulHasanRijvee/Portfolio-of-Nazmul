import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/constants/app_text_styles.dart';
import 'package:flutter7_portfolio/data/models/about_section_model.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/asset_paths.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut
      )
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {

          final width = constraints.maxWidth;
          if(width < AppBreakpoints.mobile) {
            return buildMobileLayout(width);
          } else if (width < 712) {
            return buildMiddleLayout(width);
          } else if (width < AppBreakpoints.tablet) {
            return buildDesktopLayout(width);
          } else {
            return buildDesktopLayout(width);
          }

        }
    );
  }

  Widget buildDesktopLayout(double width) {

    final double ratio = (width / AppBreakpoints.desktop).clamp(0.5, 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60 * ratio),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text(
            AppStrings.aboutMe,
            style: AppTextStyles.aboutMeStyle
                .copyWith(fontSize: 14 * ratio),
          ),
          const SizedBox(height: 10),
          Text(
            AppStrings.aboutPrecision,
            style: AppTextStyles.aboutPrecisionStyle
                .copyWith(fontSize: 24 * ratio),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Stack(
                children: [
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      width: 500 * ratio,
                      height: 519.28 * ratio,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryColor.withValues(alpha: 0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset.fromDirection(3, 3), // changes position of shadow
                          ),
                        ]
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      clipBehavior: .antiAliasWithSaveLayer,
                      child: SvgPicture.asset(
                        AssetPaths.about,
                        fit: .cover,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 9,
                child: Column(
                  mainAxisSize: .min,
                  mainAxisAlignment: .center,
                  children: [
                    SizedBox(
                      width: 670 * ratio,
                      child: Text(
                        AppStrings.aboutDescription,
                        style: AppTextStyles.aboutDescriptionStyle
                            .copyWith(fontSize: 20 * ratio),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: 120 * ratio, // edge case
                      child: ListView.separated(
                        padding: .zero,
                        shrinkWrap: true,
                        scrollDirection: .horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: AboutSectionModel.aboutData.length,
                        itemBuilder: (BuildContext context, int index) {

                          final model = AboutSectionModel.aboutData[index];

                          return buildAboutContainer(ratio, model);
                        },
                        separatorBuilder: (context, index) => SizedBox(width: 50 * ratio),
                      ),
                    )
                  ],
                ),
              ),
            ],

          ),
        ],
      ),
    );

  }

  Widget buildTabletLayout(double width) {

    return SizedBox();

  }


  Widget buildMiddleLayout(double width) {

    return SizedBox();

  }

  Widget buildMobileLayout(double width) {

    return SizedBox();

  }

  Widget buildAboutContainer(double ratio, AboutSectionEntity model) {

    return Container(
      padding: .only(left: 40 * ratio, top: 30 * ratio),
      height: 120 * ratio,
      width: 190 * ratio,
      decoration: BoxDecoration(
        color: AppColors.aboutContainer,
        borderRadius: BorderRadiusGeometry.circular(8),
        border: BoxBorder.all(
          color: AppColors.border, // Control border color
          width: 0.5
        )
      ),
      child:  Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text(
            model.title,
            style: AppTextStyles.aboutContainerTitleStyle
                .copyWith(fontSize: 24 * ratio),
          ),
          SizedBox(height: 10 * ratio),
          Text(
            model.subTitle,
            style: AppTextStyles.aboutContainerSubTitleStyle
                .copyWith(fontSize: 16 * ratio),
          )
        ]
      ),
    );

  }

}

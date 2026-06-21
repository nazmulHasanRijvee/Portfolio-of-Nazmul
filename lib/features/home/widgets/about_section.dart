import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/constants/app_text_styles.dart';
import 'package:flutter7_portfolio/data/models/about_section_model.dart';
import 'package:flutter7_portfolio/features/home/widgets/section_header.dart';
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

  late final ValueNotifier<bool> _isHover;

  @override
  void initState() {
    super.initState();

    _isHover = ValueNotifier(false);

  }

  @override
  void dispose() {
    _isHover.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {

          final width = constraints.maxWidth;
          if(width < AppBreakpoints.mobile) {
            return buildMobileLayout(width);
          } else if (width <= 1023) {
            return buildMiddleLayout(width);
          } else if (width < AppBreakpoints.tablet) {
            return buildTabletLayout(width);
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
          // unpacking list using spread operator
          // ...buildHeader(ratio, false),
          SectionHeader(ratio: ratio, isMobile: false),
          const SizedBox(height: 60),
          Row(
            children: [
              buildAboutImage(ratio),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 9,
                child: buildAboutDescription(ratio, false),
              ),
            ],

          ),
        ],
      ),
    );

  }

  Widget buildTabletLayout(double width) {

    final double ratio = (width / AppBreakpoints.tablet).clamp(0.5, 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40 * ratio),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          // unpacking list using spread operator
          // ...buildHeader(ratio, false),
          SectionHeader(ratio: ratio, isMobile: false),
          const SizedBox(height: 40),
          Row(
            children: [
              buildAboutImage(ratio),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 9,
                child: buildAboutDescription(ratio, false),
              ),
            ],

          ),
        ],
      ),
    );

  }


  Widget buildMiddleLayout(double width) {

    final double ratio = (width / (AppBreakpoints.tablet * 1.2)).clamp(0.5, 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30 * ratio),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          // unpacking list using spread operator
          // ...buildHeader(ratio, false),
          SectionHeader(ratio: ratio, isMobile: false),
          const SizedBox(height: 40),
          Row(
            children: [
              buildAboutImage(ratio),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 9,
                child: buildAboutDescription(ratio, true),
              ),
            ],

          ),
        ],
      ),
    );

  }

  Widget buildMobileLayout(double width) {

    final double ratio = (width / AppBreakpoints.mobile).clamp(0.5, 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24 * ratio),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          // unpacking list using spread operator
          // ...buildHeader(ratio, true),
          SectionHeader(ratio: ratio, isMobile: true),
          const SizedBox(height: 40),
          Align(
            alignment: .center,
              child: buildAboutImage(ratio)),
          const SizedBox(height: 32),
          buildAboutDescriptionForMobile(ratio),
        ],
      ),
    );

  }

  Column buildAboutDescription(double ratio, bool isMiddle) {
    return Column(
      mainAxisSize: .min,
      mainAxisAlignment: .center,
      children: [
        buildDescriptionText(ratio, false),
        const SizedBox(height: 40),
        SizedBox(
          height: 120 * ratio, // edge case
          child: ListView.separated(
            clipBehavior: .antiAliasWithSaveLayer,
            padding: .zero,
            shrinkWrap: true,
            scrollDirection: .horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: AboutSectionModel.aboutData.length,
            itemBuilder: (BuildContext context, int index) {

              final model = AboutSectionModel.aboutData[index];

              return buildAboutContainer(ratio, model, false);
            },
            separatorBuilder: (context, index) =>
                SizedBox(width: isMiddle ? 10 * ratio: 50 * ratio),
          ),
        )
      ],
    );
  }

  Widget buildDescriptionText(double ratio, bool isMobile) {
    return Container(
      margin: isMobile ? .only(left: 15 * ratio) : null,
      width: isMobile ? double.infinity * ratio : 670 * ratio,
      child: Text(
        AppStrings.aboutDescription,
        style: AppTextStyles.aboutDescriptionStyle
            .copyWith(fontSize: isMobile ? 24 * ratio : 20 * ratio),
      ),
    );
  }

  Widget buildAboutImage(double ratio) {
    return MouseRegion(
      onEnter: (event) {
        _isHover.value = true;
        //_controller.forward();
        },
      onExit: (event) {
        _isHover.value = false;
        //_controller.stop();
      },
      child: Stack(
        children: [
          ValueListenableBuilder(
            valueListenable: _isHover,
            builder: (BuildContext context, bool value, child) {
              return Container(
                width: 500 * ratio,
                height: 519.28 * ratio,
                decoration: BoxDecoration(
                    boxShadow: [
                      if(_isHover.value)
                        BoxShadow(
                          color: AppColors.primaryColor.withValues(alpha: 0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset.fromDirection(3, 3), // changes position of shadow
                        ),
                    ]
                ),
              );
            }
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
    );
  }

  Widget buildAboutContainer(double ratio, AboutSectionEntity model, bool isMiddle) {

    return Container(
      padding: .only(
          left: isMiddle ? 15 * ratio : 40 * ratio, // 15 old
          top: isMiddle ? 20 * ratio : 30 * ratio,
      ),
      height: isMiddle? 110 * ratio : 120 * ratio,
      width: isMiddle ? 40 * ratio : 190 * ratio, // 40 old
      decoration: BoxDecoration(
        color: AppColors.aboutContainer,
        borderRadius: BorderRadiusGeometry.circular(4),
        border: BoxBorder.all(
          color: AppColors.aboutContainerBorder, // Control border color
          width: 1.0
        )
      ),
      child:  Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Text(
            model.title,
            style: AppTextStyles.aboutContainerTitleStyle
                .copyWith(
                fontSize: 24 * ratio
            ),
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

  Column buildAboutDescriptionForMobile(double ratio) {
    return Column(
      mainAxisSize: .min,
      children: [
        buildDescriptionText(ratio, true),
        const SizedBox(height: 40),
        Row(
            mainAxisAlignment: .spaceAround,
            spacing: 4 * ratio,
            children: List.generate(
          AboutSectionModel.aboutData.length,
          (int index) {

            final model = AboutSectionModel.aboutData[index];

            return buildAboutContainerForMobile(ratio, model);
          },
          )
        )
      ],
    );
  }

  Widget buildAboutContainerForMobile(double ratio, AboutSectionEntity model) {

    return Container(
      padding: .only(
        left: 30 * ratio, // 15 old
        top:  40 * ratio,
      ),
      margin: .symmetric(horizontal: 10),
      height: 160 * ratio,
      width:  150 * ratio, // 40 old
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
                  .copyWith(
                  fontSize: 28 * ratio
              ),
            ),
            SizedBox(height: 16 * ratio),
            Text(
              model.subTitle,
              style: AppTextStyles.aboutContainerSubTitleStyle
                  .copyWith(fontSize: 20 * ratio),
            )
          ]
      ),
    );

  }

}

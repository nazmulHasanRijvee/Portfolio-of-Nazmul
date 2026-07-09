import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/features/home/widgets/section_header.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/asset_paths.dart';
import '../../../data/models/about_section_model.dart';

class AboutSection extends StatefulWidget {

  const AboutSection({super.key}); // _aboutKey is directly assigned

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> with SingleTickerProviderStateMixin {

  // ValueNotifier to detect mouse pointer hovering
  late final ValueNotifier<bool> _isHover;

  @override
  void initState() {
    super.initState();
    // initializing ValueNotifier
    _isHover = ValueNotifier(false);

  }

  @override
  void dispose() {
    _isHover.dispose(); // must dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build different UI layouts based on maximumWidth (platform)
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

  /// Desktop
  Widget buildDesktopLayout(double width) {
    // Determine scale ratio based on maximumWidth and platform break points
    // clamp method ensures ratio is not greater than 1.0 to stop overgrow
    final double ratio = (width / AppBreakpoints.desktop).clamp(0.5, 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60 * ratio),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          // Section header to show section number & title
          SectionHeader(ratio: ratio),
          const SizedBox(height: 60),
          Row(
            children: [
              buildAboutImage(ratio),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 9,
                child: buildAboutDescription(ratio: ratio),
              ),
            ],

          ),
        ],
      ),
    );

  }

  /// Tablet
  Widget buildTabletLayout(double width) {

    final double ratio = (width / AppBreakpoints.tablet).clamp(0.5, 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40 * ratio),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          SectionHeader(ratio: ratio),
          const SizedBox(height: 40),
          Row(
            children: [
              buildAboutImage(ratio),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 9,
                child: buildAboutDescription(ratio: ratio),
              ),
            ],

          ),
        ],
      ),
    );

  }

  /// Transition between tablet to mobile
  Widget buildMiddleLayout(double width) {

    final double ratio = (width / (AppBreakpoints.tablet * 1.2)).clamp(0.5, 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30 * ratio),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          SectionHeader(ratio: ratio),
          const SizedBox(height: 40),
          Row(
            children: [
              buildAboutImage(ratio),
              const Spacer(
                flex: 1,
              ),
              Expanded(
                flex: 9,
                child: buildAboutDescription(ratio: ratio, isMiddle: true),
              ),
            ],

          ),
        ],
      ),
    );

  }

  /// Mobile
  Widget buildMobileLayout(double width) {

    final double ratio = (width / AppBreakpoints.mobile).clamp(0.5, 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24 * ratio),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
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

  /// build about image
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
                return buildImageContainer(ratio);
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

  // build image container for buildAboutImage()
  Container buildImageContainer(double ratio) {
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

  /// build about description
  Column buildAboutDescription({required double ratio, bool isMiddle = false}) {
    return Column(
      mainAxisSize: .min,
      mainAxisAlignment: .center,
      children: [
        buildDescriptionText(ratio: ratio), /// CH
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

              return buildAboutContainer(ratio: ratio, model: model);
            },
            separatorBuilder: (context, index) =>
                SizedBox(width: (isMiddle? 10 : 50) * (ratio)),
          ),
        )
      ],
    );
  }

  // build description text for buildAboutDescription()
  Widget buildDescriptionText({required double ratio, bool isMobile = false}) {
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

  // build about container for buildAboutDescription() & buildAboutDescriptionForMobile()
  Widget buildAboutContainer({required double ratio, required AboutSectionEntity model, bool isMobile = false}) { // work on this

    return Container(
      padding: .only(
          left: (isMobile? 30 : 40) * ratio,
          top:  (isMobile?  40 : 30) * ratio,
      ),
      height: (isMobile? 160 : 120) * ratio,
      width:  (isMobile? 150 : 190) * ratio, // 40 old
      decoration: BoxDecoration(
        color: AppColors.aboutContainer,
        borderRadius: BorderRadiusGeometry.circular(4),
        border: BoxBorder.all(
          color: AppColors.aboutContainerBorder, // Control border color
          width: 1.0 // 0.5 for mobile if needed
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
                fontSize: (isMobile? 28 : 24) * ratio
            ),
          ),
          SizedBox(height: (isMobile? 16 : 10) * ratio),
          Text(
            model.subTitle,
            style: AppTextStyles.aboutContainerSubTitleStyle
                .copyWith(fontSize: (isMobile? 20 : 16) * ratio),
          )
        ]
      ),
    );

  }

  /// build About description for buildMobileLayout
  Column buildAboutDescriptionForMobile(double ratio) {
    return Column(
      mainAxisSize: .min,
      children: [
        buildDescriptionText(ratio: ratio, isMobile: true),
        const SizedBox(height: 40),
        Row(
            mainAxisAlignment: .spaceAround,
            spacing: 4 * ratio,
            children: List.generate(
          AboutSectionModel.aboutData.length,
          (int index) {

            final model = AboutSectionModel.aboutData[index];

            return buildAboutContainer(ratio: ratio, model: model, isMobile: true);
          },
          )
        )
      ],
    );
  }

}

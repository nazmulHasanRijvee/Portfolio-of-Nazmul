import 'package:flutter/material.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/skill_section_model.dart';
import 'section_header.dart';

class SkillSection extends StatefulWidget {
  const SkillSection({super.key}); // _skillsKey is directly assigned

  @override
  State<SkillSection> createState() => _SkillSectionState();
}

class _SkillSectionState extends State<SkillSection> {

  // ValueNotifier to detect mouse pointer hovering
  late final ValueNotifier<int> currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex  = ValueNotifier<int>(9);
  }

  @override
  void dispose() {
    currentIndex.dispose(); // must dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {

          final width = constraints.maxWidth;
          if(width < AppBreakpoints.mobile) {
            return buildMobileLayout(width);
          } else if (width < AppBreakpoints.tablet) {
            return buildTabletLayout(width);
          } else {
            return buildDesktopLayout(width);
          }

        }
    );

  }

  /// For desktop
  Widget buildDesktopLayout(double width) {

    final double ratio = (width / AppBreakpoints.desktop).clamp(0.5, 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 60 * ratio),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          // Section header to show section number & title
          SectionHeader(
              ratio: ratio,
              isMobile: false,
              sectionNumber: AppStrings.skills,
              sectionTitle: AppStrings.skillDetails,
          ),
          const SizedBox(height: 60),
          Flexible(
            child: buildSkillGrid(
              ratio: ratio,
              crossAxisCount: 4,
              crossAxisSpacing: 30,
              mainAxisSpacing: 40,
              childAspectRatio: 1.2,
            ),
          )
        ],
      )
    );

  }

  /// For tablet
  Widget buildTabletLayout(double width) {

    final double ratio = (width / AppBreakpoints.tablet).clamp(0.5, 1.0);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40 * ratio),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            SectionHeader(
                ratio: ratio,
                isMobile: false,
                sectionNumber: AppStrings.skills,
                sectionTitle: AppStrings.skillDetails,
            ),
            const SizedBox(height: 60),
            Flexible(
              child: buildSkillGrid(
                ratio: ratio,
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 40,
                childAspectRatio: 2,
                isTablet: true,
              ),
            )
          ],
        )
    );

  }

  /// For mobile
  Widget buildMobileLayout(double width) {

    final double ratio = (width / AppBreakpoints.mobile).clamp(0.5, 1.0);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24 * ratio),
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            SectionHeader(
                ratio: ratio,
                isMobile: true,
                sectionNumber: AppStrings.skills,
                sectionTitle: AppStrings.skillDetails,
            ),
            const SizedBox(height: 40),
            Flexible(
              child: buildSkillListView(ratio)
            )
          ],
        )
    );

  }


  /// build grid of skills for desktop & tablet
  GridView buildSkillGrid({
    required double ratio,
    required int crossAxisCount,
    required double crossAxisSpacing,
    required double mainAxisSpacing,
    required double childAspectRatio,
    bool isTablet = false
    }) {
    return GridView.builder(
        clipBehavior: .none,
        shrinkWrap: true,
        padding: .zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing * ratio,
            mainAxisSpacing: mainAxisSpacing * ratio,
            childAspectRatio: childAspectRatio * ratio
        ),
        itemCount: SkillSectionModel.skillModels.length,
        itemBuilder: (BuildContext context, int index) {

          final model = SkillSectionModel.skillModels[index];

          return buildMouseRegion(
            index: index,
            child: ValueListenableBuilder(
                valueListenable: currentIndex,
                builder: (context, int value, child) {
                  return buildSkillContainer(
                      ratio: ratio,
                      model: model,
                      isHovered:  index == value,
                      isTablet: isTablet,
                  );
                }
            ),
          );

        }
    );
  }

  // build skill container for buildSkillGrid()
  Widget buildSkillContainer({
    required double ratio,
    required SkillSectionEntity model ,
    required bool isHovered,
    required bool isTablet,
  }){

    return Container(
      padding: .only(left: isTablet ? 55 * ratio : 35 * ratio),
      alignment: .centerStart,

      decoration: BoxDecoration(
          color: AppColors.skillContainer,
          borderRadius: BorderRadiusGeometry.circular(6),
          border: isHovered ? Border.all(
              color: AppColors.primaryColor.withValues(alpha: 0.5),
              width: 0.5
          ) : null
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: .start,
        children: [
          Icon(
            model.icon,
            color: AppColors.primaryColor,
            size: isTablet ? 58 * ratio : 44 * ratio,
          ),
          SizedBox(height: 20 * ratio),
          Text(
            model.label,
            style: AppTextStyles.skillLabelStyle
                .copyWith(fontSize: isTablet ? 32 * ratio : 26 * ratio),

          ),
          SizedBox(height: isTablet ? 25 * ratio : 15 * ratio),
          buildSkillRow(
              ratio: ratio,
              skills: model.skills,
              isTablet: isTablet
          )
        ],
      ),

    );

  }

  // build skill row for buildSkillContainer()
  Widget buildSkillRow({ required double ratio, required List<String> skills, bool isTablet = false}){

    return SizedBox(
      width: isTablet ? 400 * ratio : 200 * ratio,
      child: Wrap(

          spacing: isTablet ? 15 * ratio : 10 * ratio,
          runSpacing: isTablet ? 15 * ratio : 10 * ratio,

          children: List.generate(skills.length, (int index){

            return Container(
              padding: .symmetric(horizontal: 10 * ratio, vertical: 5 * ratio),
              decoration: BoxDecoration(
                  color: AppColors.subSkillContainer,
                  borderRadius: BorderRadiusGeometry.circular(3)
              ),
              child: Text(
                  skills[index],
                  style: AppTextStyles.subSkillStyle
                      .copyWith(fontSize: isTablet ? 14 * ratio : 12 * ratio)
              ),
            );

          })

      ),
    );

  }

  // build mouse region for buildSkillListView() and buildSkillGrid()
  Widget buildMouseRegion({required int index, required Widget child}){
    return MouseRegion(
        onEnter: (event) {
          currentIndex.value = index;
        },
        onExit: (event) {
          currentIndex.value = 9;
        },
        child: child
    );
  }

  /// build list of skills for mobile
  Widget buildSkillListView(double ratio) {

    return ListView.separated(
        clipBehavior: .none,
        shrinkWrap: true,
        padding: .zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: SkillSectionModel.skillModels.length,
        itemBuilder: (BuildContext context, int index) {

          final model = SkillSectionModel.skillModels[index];

          return buildMouseRegion(
            index: index,
            child: ValueListenableBuilder(
                valueListenable: currentIndex,
                builder: (context, int value, child) {
                  return buildSkillContainerForMobile(
                    ratio: ratio,
                    model: model,
                    isHovered:  index == value,
                  );
                }
            ),
          );

        },
        separatorBuilder: (context, index) => const SizedBox(height: 15),
    );

  }


  // build skill container for buildSkillListView()
  Widget buildSkillContainerForMobile({
    required double ratio,
    required SkillSectionEntity model ,
    required bool isHovered,
  }){

    return Container(
      padding: .only(left: 50 * ratio, top: 45 * ratio, bottom: 45 * ratio),
      alignment: .centerStart,

      decoration: BoxDecoration(
          color: AppColors.skillContainer,
          borderRadius: BorderRadiusGeometry.circular(6),
          border: isHovered ? Border.all(
              color: AppColors.primaryColor.withValues(alpha: 0.5),
              width: 0.5
          ) : null
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: .start,
        children: [
          Icon(
            model.icon,
            color: AppColors.primaryColor,
            size: 54 * ratio,
          ),
          SizedBox(height: 20 * ratio),
          Text(
            model.label,
            style: AppTextStyles.skillLabelStyle
                .copyWith(fontSize: 26 * ratio),

          ),
          SizedBox(height: 15 * ratio),
          buildSkillRowForMobile(
              ratio: ratio,
              skills: model.skills,
          )
        ],
      ),

    );

  }

  // build skill row for buildSkillContainerForMobile()
  Widget buildSkillRowForMobile({ required double ratio, required List<String> skills}){

    return SizedBox(
      width: 400 * ratio,
      child: Wrap(

          spacing: 12 * ratio,
          runSpacing: 12 * ratio,

          children: List.generate(skills.length, (int index){

            return Container(
              padding: .symmetric(horizontal: 10 * ratio, vertical: 5 * ratio),
              decoration: BoxDecoration(
                  color: AppColors.subSkillContainer,
                  borderRadius: BorderRadiusGeometry.circular(3)
              ),
              child: Text(
                  skills[index],
                  style: AppTextStyles.subSkillStyle
                      .copyWith(fontSize: 12 * ratio) // may need 14 fontSize
              ),
            );

          })

      ),
    );

  }

}

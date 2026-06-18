import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/constants/app_colors.dart';
import 'package:flutter7_portfolio/core/constants/app_text_styles.dart';
import 'package:flutter7_portfolio/data/models/skill_section_model.dart';
import 'package:flutter7_portfolio/features/home/widgets/section_header.dart';

import '../../../core/constants/app_breakpoints.dart';

class SkillSection extends StatefulWidget {
  const SkillSection({super.key});

  @override
  State<SkillSection> createState() => _SkillSectionState();
}

class _SkillSectionState extends State<SkillSection> {

  late final ValueNotifier<int> currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex  = ValueNotifier<int>(9);
  }

  @override
  void dispose() {
    currentIndex.dispose();
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
          SectionHeader(ratio: ratio, isMobile: false),
          const SizedBox(height: 60),
          Flexible(
            child: GridView.builder(
                clipBehavior: .none,
                shrinkWrap: true,
                padding: .zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 30 * ratio,
                    mainAxisSpacing: 40 * ratio,
                    childAspectRatio: 1.2 * ratio
                ),
                itemCount: SkillSectionModel.skillModels.length,
                itemBuilder: (BuildContext context, int index) {

                  final model = SkillSectionModel.skillModels[index];

                  return MouseRegion(
                      onHover: (event) {
                        currentIndex.value = index;
                        },
                      onExit: (event) {
                        currentIndex.value = 9;
                        },
                      child: ValueListenableBuilder(
                        valueListenable: currentIndex,
                        builder: (context, int value, child) {
                          return buildSkillContainer(
                              ratio: ratio,
                              model: model,
                              isHovered:  index == value
                          );
                        }
                      )
                  );

                }
            ),
          )
        ],
      )
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

  Widget buildSkillContainer({required double ratio, required SkillSectionEntity model , required bool isHovered}){

    return Container(
      padding: .only(left: 35 * ratio, ),
      alignment: .centerStart,

      decoration: BoxDecoration(
        color: AppColors.skillContainer,
        borderRadius: BorderRadiusGeometry.circular(6),
        boxShadow: [
          if(isHovered)
            BoxShadow(
                blurRadius: 3.5,
                spreadRadius: 3.5,
                color: AppColors.primaryColor.withValues(alpha: 0.4),
                offset: const Offset(2, 2)
            )
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: .start,
        children: [
          Icon(
            model.icon,
            color: AppColors.primaryColor,
            size: 44 * ratio,
          ),
          SizedBox(height: 20 * ratio),
          Text(
            model.label,
            style: AppTextStyles.skillLabelStyle
                .copyWith(fontSize: 26 * ratio),

          ),
          SizedBox(height: 15 * ratio),
          buildSkillRow(ratio, model.skills)
        ],
      ),

    );

  }

  Widget buildSkillRow(double ratio, List<String> skills){

    return SizedBox(
      width: 200 * ratio,
      child: Wrap(

        spacing: 10 * ratio,
        runSpacing: 10 * ratio,

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
                  .copyWith(fontSize: 12 * ratio)
            ),
          );

        })

      ),
    );

  }

}

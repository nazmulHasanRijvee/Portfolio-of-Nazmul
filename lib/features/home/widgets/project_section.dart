import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/constants/app_strings.dart';
import 'package:flutter7_portfolio/core/constants/app_text_styles.dart';
import 'package:flutter7_portfolio/core/utils/url_launcher.dart';
import 'package:flutter7_portfolio/features/home/widgets/section_header.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/asset_paths.dart';
import '../../../data/models/project_section_model.dart';

class ProjectSection extends StatefulWidget {
  const ProjectSection({super.key});

  @override
  State<ProjectSection> createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectSection> with TickerProviderStateMixin {

  late final List<AnimationController> _animationControllers;
  late final List<Animation<double>> _animations;


  @override
  void initState() {
    super.initState();

    _animationControllers = List.generate(4, (index) => AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    ));

    _animations = _animationControllers.map(
        (e) => Tween<double>(begin: 1.0, end: 1.04)
            .animate(CurvedAnimation(parent: e, curve: Curves.easeIn))
    ).toList();


  }

  @override
  void dispose() {
    // _controller.dispose();
    for(final c in _animationControllers){
      c.dispose();
    }
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

  Widget buildDesktopLayout(double width) {

    final ratio = (width / AppBreakpoints.desktop).clamp(0.5, 1.0);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: (60.0 * ratio)), // ratio added
        child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              SectionHeader(
                  ratio: ratio,
                  isMobile: false,
                  sectionNumber: AppStrings.projects,
                  sectionTitle: AppStrings.projectDetails,
              ),
              const SizedBox(height: 60),
              buildProjectOne(ratio, false),
              const SizedBox(height: 40),
              Flexible(
                  child: buildGrid(ratio, false)
              )
            ]
        )
    );

  }

  Widget buildTabletLayout(double width){

    /// NOTE: Best practice usage bool isTablet but minimal only where absolutely needed
    ///  instead increase the ratio by multiplying with 1.2 or 1.2 and increase
    ///  lower shrinking range in .clamp() also use State hoisting for better reusability and clean code
    final ratio = (width / (AppBreakpoints.tablet * 1.2)).clamp(0.5, 1.0);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: (40.0 * ratio)), // ratio added
        child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              SectionHeader(
                ratio: ratio,
                isMobile: false,
                sectionNumber: AppStrings.projects,
                sectionTitle: AppStrings.projectDetails,
              ),
              const SizedBox(height: 60),
              buildProjectOne(ratio, true),
              const SizedBox(height: 40),
              Flexible(
                  child: buildGrid(ratio, true)
              )
            ]
        )
    );

  }

  Widget buildProjectOne(double ratio, bool isTablet) {
    return MouseRegion(
      onHover: (event) {
        _animationControllers[3].forward();
      },
      onExit: (event) {
        _animationControllers[3].reverse();
      },
      child: Container(
        padding: .zero,
        alignment: .centerStart,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.projectOneContainer,
            border: Border.all(
              width: 0.6,
              color: AppColors.primaryColor.withValues(alpha: 0.4),
              strokeAlign: BorderSide.strokeAlignOutside
            )
        ),
        child: Row(
          mainAxisAlignment: .start,
          children: [
            Expanded(
                flex: 4,
                child: buildProjectOneImage(ratio)
            ),
            SizedBox(width: 100 * ratio),

            Expanded(
              flex: 4,
              child: buildProjectOneDescription(ratio, isTablet),
            ),

          ],
        ),

      ),
    );
  }

  Widget buildProjectOneDescription(double ratio, bool isTablet) {
    return Column(
                crossAxisAlignment: .start,
                mainAxisSize: .min,
                children: [
                  Row(
                    mainAxisSize: .min,
                    mainAxisAlignment: .start,
                    crossAxisAlignment: .start,
                    children: [
                      Text(
                        ProjectSectionModel.projectOne.title,
                        style: AppTextStyles.projectOneTitle
                            .copyWith(fontSize: isTablet ? 20 * ratio : 26 * ratio),
                      ),
                      const Spacer(flex: 7,),
                      Icon(
                        Icons.code_rounded,
                        color: Colors.white54,
                        size: isTablet ? 20 * ratio : 26 * ratio,
                      ),
                      const Spacer(flex: 3,),
                    ],
                  ),
                  SizedBox(height: 38 * ratio),
                  SizedBox(
                    width: 500 * ratio,
                    child: Text(
                      ProjectSectionModel.projectOne.description,
                      style: AppTextStyles.projectOneDescription
                          .copyWith(fontSize: 16 * ratio), /// Mark
                    ),
                  ),
                  SizedBox(height: 30 * ratio),
                  buildProjectOneTags(ratio, isTablet),
                  SizedBox(height: 35 * ratio),
                  FilledButton(
                    onPressed: () => UrlLauncher.openLLMApp(),
                    style: FilledButton.styleFrom(
                      padding: .symmetric(horizontal: 48 * ratio, vertical: 16 * ratio),
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    child: Text(
                      AppStrings.projectOneDetails,
                      style: AppTextStyles.projectOneButton
                          .copyWith(fontSize: 16 * ratio),
                    ),
                  )
                ]
            );
  }

  Widget buildProjectOneTags(double ratio, bool isTablet) {

    final tagList = ProjectSectionModel.projectOne.tags;

    return Wrap(
      spacing: 12 * ratio,
      children: List.generate(tagList.length,
          (int index) =>
              Container(
                padding: .symmetric(horizontal: 12 * ratio, vertical: 6 * ratio),
                decoration: BoxDecoration(
                  color: AppColors.projectOneTag,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.5),
                    width: 0.4
                  )
                ),
                child: Text(
                  tagList[index],
                  style: AppTextStyles.projectOneTag
                      .copyWith(fontSize: 14 * ratio),
                ),
              )
      )
    );
  }

  Widget buildAnimation({ required Widget child, required Animation<double> animation}) {

    return RepaintBoundary(
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.scale(
              scale: animation.value,
              child: child,
            );
          },
        child: child,
      ),
    );

  }

  Widget buildProjectOneImage(double ratio) {
    return SizedBox(
            width: 620 * ratio,
            height: 520 * ratio,
            child: ClipRRect(
              borderRadius: .circular(4),
              child: buildAnimation(
                  animation: _animations[3],
                  child: Image.asset(
                    AssetPaths.projectOne,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    isAntiAlias: true,
                  ),
              )
            ),
          );
  }

  Widget buildGrid(double ratio, bool isTablet) {
    return GridView.builder(
        clipBehavior: .none,
        shrinkWrap: true,
        padding: .zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 30 * ratio,
            mainAxisSpacing: 40 * ratio,
            childAspectRatio: (0.99 * ratio).clamp(
                isTablet ? 0.80 : 0.90, 0.99
            )
        ),
        itemCount: ProjectSectionModel.bottomProjects.length,
        itemBuilder: (BuildContext context, int index) {

          final model = ProjectSectionModel.bottomProjects[index];

          return MouseRegion(
            onEnter: (event) {
              _animationControllers[index].forward();
            },
            onExit: (event) {
              _animationControllers[index].reverse();
            },
            child: InkWell(
              onTap: () => UrlLauncher.openSubproject(index),
              child: Stack(
                children: [
                  buildSubProjectContainer(index: index, ratio: ratio, model: model),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: buildCodeIcon(ratio)
                  )
                ],
              ),
            ),
          );

        }
    );
  }

  Widget buildCodeIcon(double ratio) {
    return Container(
      padding: .symmetric(horizontal: 12 * ratio, vertical: 6 * ratio),
      decoration: BoxDecoration(
          color: AppColors.skillContainer,
          borderRadius: BorderRadius.circular(6)
      ),
      child: Icon(
        Icons.code_rounded,
        color: Colors.white70,
        size: 20,
      ),
    );
  }

  Container buildSubProjectContainer({required int index, required double ratio, required ProjectSectionEntity model, bool isMobile = false}) {
    return Container(
      padding: isMobile ? .only(bottom: 30 * ratio) : .zero,
      alignment: .topStart,
      decoration: BoxDecoration(
          color: AppColors.skillContainer,
          borderRadius: BorderRadius.circular(2)
      ),
      child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            buildAnimation(
              animation: _animations[index],
              child: Image.asset(
                ProjectSectionModel.bottomProjects[index].imageUrl,
                width: double.maxFinite * ratio,
                height: 200 * ratio,
                fit: .cover,
              ),
            ),
            SizedBox(height: 40 * ratio),
            buildSubProjectDescription(ratio, model, isMobile)
          ]
      ),
    );
  }

  Widget buildSubProjectDescription(double ratio, ProjectSectionEntity model, bool isMobile) {

    return Padding(
      padding: EdgeInsets.only(left: isMobile? 32.0 * ratio : 24.0 * ratio),
      child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            Text(
              model.title,
              style: AppTextStyles.projectOneTitle
                  .copyWith(fontSize: isMobile ? 24 * ratio :  20 * ratio),
            ),
            SizedBox(height: 24 * ratio),
            SizedBox(
              width: isMobile? 470 * ratio : 370 * ratio,
              child: Text(
                model.description,
                style: AppTextStyles.projectOneDescription
                    .copyWith(fontSize: isMobile ? 18 * ratio : 14 * ratio), /// Mark for mobile old 20
              ),
            ),
            SizedBox(height: 20 * ratio),
            buildSubProjectTags(ratio, model.tags)
          ]
      ),
    );

  }

  Widget buildSubProjectTags(double ratio, List<String> tagList) {


    return Wrap(
        spacing: 12 * ratio,
        children: List.generate(tagList.length,
                (int index) =>
                Container(
                  padding: .symmetric(horizontal: 12 * ratio, vertical: 6 * ratio),
                  decoration: BoxDecoration(
                    color: AppColors.subProjectTag,
                    borderRadius: BorderRadius.circular(3),

                  ),
                  child: Text(
                    tagList[index],
                    style: AppTextStyles.projectOneTag
                        .copyWith(fontSize: 14 * ratio, color: Colors.white),
                  ),
                )
        )
    );
  }

  /// Mobile layout
  Widget buildMobileLayout(double width){

    final ratio = (width / AppBreakpoints.mobile).clamp(0.5, 1.0);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: (24.0 * ratio)), // ratio added
        child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              SectionHeader(
                ratio: ratio,
                isMobile: true,
                sectionNumber: AppStrings.projects,
                sectionTitle: AppStrings.projectDetails,
              ),
              const SizedBox(height: 40),
              buildProjectOneForMobile(ratio),
              const SizedBox(height: 40),
              Flexible(
                  child: buildListForMobile(ratio)
              )
            ]
        )
    );

  }

  Widget buildProjectOneForMobile(double ratio) {
    return MouseRegion(
      onHover: (event) {
        _animationControllers[3].forward();
      },
      onExit: (event) {
        _animationControllers[3].reverse();
      },
      child: Container(
        padding: .zero,
        alignment: .centerStart,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.projectOneContainer,
            border: Border.all(
                width: 0.6,
                color: AppColors.primaryColor.withValues(alpha: 0.4),
                strokeAlign: BorderSide.strokeAlignOutside
            )
        ),
        child: Column(
          mainAxisAlignment: .start,
          children: [
            buildProjectOneImage(ratio),
            SizedBox(height: 60 * ratio),

            Padding(
              padding: EdgeInsets.only(left: 30.0 * ratio, bottom: 60.0 * ratio),
              child: buildProjectOneDescriptionForMobile(ratio),
            ),

          ],
        ),

      ),
    );
  }

  Widget buildProjectOneDescriptionForMobile(double ratio) {
    return Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Row(
            spacing: 120 * ratio,
            mainAxisSize: .min,
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              SizedBox(
                width: 300 * ratio,
                child: Text(
                  ProjectSectionModel.projectOne.title,
                  softWrap: true,
                  style: AppTextStyles.projectOneTitle
                      .copyWith(fontSize: 26 * ratio),
                ),
              ),
              Icon(
                Icons.code_rounded,
                color: Colors.white54,
                size: 26 * ratio,
              )
            ],
          ),
          SizedBox(height: 38 * ratio),
          SizedBox(
            width: 450 * ratio,
            child: Text(
              ProjectSectionModel.projectOne.description,
              style: AppTextStyles.projectOneDescription
                  .copyWith(fontSize: 18 * ratio),  /// Mark
            ),
          ),
          SizedBox(height: 30 * ratio),
          buildProjectOneTags(ratio, false),
          SizedBox(height: 35 * ratio),
          FilledButton(
            onPressed: () => UrlLauncher.openLLMApp(),
            style: FilledButton.styleFrom(
              padding: .symmetric(horizontal: 48 * ratio, vertical: 16 * ratio),
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.elliptical(5, 8)),
              ),
            ),
            child: Text(
              AppStrings.projectOneDetails,
              style: AppTextStyles.projectOneButton
                  .copyWith(fontSize: 16 * ratio),
            ),
          )
        ]
    );
  }

  Widget buildListForMobile(double ratio) {
    return ListView.separated(
        clipBehavior: .none,
        shrinkWrap: true,
        padding: .zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ProjectSectionModel.bottomProjects.length,
        itemBuilder: (BuildContext context, int index) {

          final model = ProjectSectionModel.bottomProjects[index];

          return MouseRegion(
            onEnter: (event) {
              _animationControllers[index].forward();
            },
            onExit: (event) {
              _animationControllers[index].reverse();
            },
            child: InkWell(
              onTap: () => UrlLauncher.openSubproject(index),
              child: Stack(
                children: [
                  buildSubProjectContainer(index: index, ratio: ratio, model: model, isMobile: true),
                  Positioned(
                      top: 10,
                      right: 10,
                      child: buildCodeIcon(ratio)
                  )
                ],
              ),
            ),
          );

        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 25),
    );
  }

}

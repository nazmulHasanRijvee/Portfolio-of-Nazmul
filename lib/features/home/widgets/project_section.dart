import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/constants/app_strings.dart';
import 'package:flutter7_portfolio/features/home/widgets/section_header.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/asset_paths.dart';

class ProjectSection extends StatefulWidget {
  const ProjectSection({super.key});

  @override
  State<ProjectSection> createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectSection> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 1.0, end: 1.06)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
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
              MouseRegion(
                onHover: (event) {
                  _controller.forward();
                },
                onExit: (event) {
                  _controller.reverse();
                },
                child: Container(
                  padding: .zero,
                  alignment: .centerStart,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.projectOneContainer,
                    border: Border.all(
                      width: 0.5,
                      color: AppColors.primaryColor.withValues(alpha: 0.4),
                    )
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 620,
                        height: 480,
                        child: ClipRRect(
                          borderRadius: .circular(4),
                          child: RepaintBoundary(
                            child: AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _animation.value,
                                  child: child,
                                );
                              },
                              child: Image.asset(
                                AssetPaths.projectOne,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                isAntiAlias: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),

                      Expanded(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisSize: .min,
                          children: [
                            Text('Hi')
                          ]
                        ),
                      )

                    ],
                  ),

                ),
              )
            ]
        )
    );

  }

  Widget buildTabletLayout(double width){

    return SizedBox();

  }

  Widget buildMiddleLayout(double width){

    return SizedBox();

  }

  Widget buildMobileLayout(double width){

    return SizedBox();

  }

}

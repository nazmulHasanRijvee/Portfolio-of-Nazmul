import 'package:flutter/material.dart';

import '../../../core/constants/app_breakpoints.dart';

class SkillSection extends StatefulWidget {
  const SkillSection({super.key});

  @override
  State<SkillSection> createState() => _SkillSectionState();
}

class _SkillSectionState extends State<SkillSection> {

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

    return SizedBox();

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

}

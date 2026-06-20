import 'package:flutter/material.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../data/models/contact_section_model.dart';

class ContactSection extends StatefulWidget {

  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> with TickerProviderStateMixin {

  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _animations;

  late final List<Animation<double>> _fadeAnimations;
  late final ValueNotifier<int> _currentIndex;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (int index) =>
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
    );


    _animations = _controllers.map(
        (e) => Tween<Offset>(begin: const Offset(-0.5, 0.0), end: Offset.zero)
            .animate(CurvedAnimation(parent: e, curve: Curves.easeIn))
    ).toList();

    _fadeAnimations = _controllers.map(
            (e) => Tween<double>(begin: 0.0, end: 1.0)
            .animate(CurvedAnimation(
                parent: e,
                curve: const Interval(0.0, 0.5, curve: Curves.easeIn)
            )
            )
    ).toList();
    
    _currentIndex = ValueNotifier(4);

  }

  @override
  void dispose() {
    for(final c in _controllers){
      c.dispose();
    }
    _currentIndex.dispose();
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

    return Align(
        alignment: .center,
        child: Column(
            crossAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              buildContactSectionHeader(ratio: ratio, isMobile: false),
              const SizedBox(height: 60),
              buildGrid(ratio),
              const SizedBox(height: 60),
              buildBottomBar(ratio)
            ]
        )
    );

  }

  Widget buildTabletLayout(double width) {

    return SizedBox();

  }

  Widget buildMobileLayout(double width) {

    return SizedBox();

  }

  Widget buildContactSectionHeader({
    required double ratio,
    required bool isMobile,
  }){

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: .center,
      children: [
        Text(
          AppStrings.contactSectionNumber,
          style: AppTextStyles.aboutMeStyle
              .copyWith(fontSize: isMobile ? 20 * ratio : 16 * ratio),
        ),
        const SizedBox(height: 10),
        Text(
          AppStrings.contactSectionHeading,
          style: AppTextStyles.aboutPrecisionStyle
              .copyWith(fontSize: isMobile ? 34 * ratio : 30 * ratio),
        ),
      ],
    );

  }

  Widget buildGrid(double ratio) {

    return GridView.builder(
        shrinkWrap: true,
        padding: .symmetric(horizontal: 60 * ratio),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 30 * ratio,
            mainAxisSpacing: 40 * ratio,
            childAspectRatio: 1.4 * ratio,
        ),
        itemCount: ContactSectionModel.contacts.length,
        itemBuilder: (BuildContext context, int index) {

          final model = ContactSectionModel.contacts[index];

          return MouseRegion(
            onEnter: (event) {
              _controllers[index].forward();
              _currentIndex.value = index;
            },
              onExit: (event) {
              _controllers[index].reverse();
              _currentIndex.value = 4;
              },
              child: GestureDetector(
                onTap: () {}, // url launcher
                child: ValueListenableBuilder(
                  valueListenable: _currentIndex,
                  builder: (BuildContext context, int value, Widget? child) {
                    return buildContactContainer(
                        ratio,
                        model,
                        _animations[index],
                        _fadeAnimations[index],
                        value == index
                    );
                  }
                ),
              )
          );

        }
    );

  }

  Widget buildContactContainer(double ratio, ContactSectionEntity model, Animation<Offset> animation, Animation<double> fadeAnimation, bool isHovered) {
    return Stack(
      alignment: .bottomCenter,
      children: [
        Container(
              alignment: .center,
              padding: .symmetric(horizontal: 24 * ratio, vertical: 24 * ratio),
              decoration: BoxDecoration(
                color: AppColors.skillContainer,
                borderRadius: BorderRadius.circular(4)
              ),
              child: Column(
                mainAxisSize: .min,
                children: [
                  buildIcon(ratio ,model, isHovered),
                  SizedBox(height: 25 * ratio),
                  Text(
                    model.title,
                    style: AppTextStyles.contactTitle
                        .copyWith(fontSize: 24 * ratio),
                  ),
                  SizedBox(height: 8 * ratio),
                  Text(
                    model.description,
                    style: AppTextStyles.contactDescription
                        .copyWith(fontSize: 20 * ratio),
                  ),
                  SizedBox(height: 20 * ratio),
                  // buildTransition(fadeAnimation, animation)
                ],
              ),
            ),
        Positioned(
          bottom: 40 / ratio,
          child: buildTransition(fadeAnimation, animation),
        )
      ],
    );
  }

  FadeTransition buildTransition(Animation<double> fadeAnimation, Animation<Offset> animation) {
    return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: animation,
                child: Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.primaryColor,
                  size: 24,
                  fontWeight: .w600,
                ),
              ),
            );
  }

  Container buildIcon(double ratio,ContactSectionEntity model, bool isHovered) {
    return Container(
      padding: .symmetric(horizontal: 10 * ratio, vertical: 8 * ratio),
      decoration: BoxDecoration(
          color: isHovered ? AppColors.primaryColor.withAlpha(50) : AppColors.subProjectTag,
          borderRadius: BorderRadius.circular(6)
      ),
      child: Icon(
        model.icon,
        color: isHovered ? AppColors.primaryColor : Colors.white70,
        size: 32 * ratio,
      ),
    );
  }

  Container buildBottomBar(double ratio) {
    return Container(
      width: double.maxFinite,
      padding: .only(top: 25 * ratio, bottom: 15 * ratio),
      alignment: .center,
      decoration: BoxDecoration(
          color: AppColors.skillContainer
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          Text(
            AppStrings.lastTitle,
            style: AppTextStyles.finalTitle
                .copyWith(fontSize: 16 * ratio),
          ),
          SizedBox(height: 10 * ratio),
          Row(
            spacing: 20 * ratio,
            mainAxisAlignment: .center,
            children: buildLastIcons(ratio, [
              Icons.mail_outline_rounded,
              Icons.code_rounded,
              Icons.terminal_rounded,
              ])
          ),
          SizedBox(height: 15 * ratio),
          Text(
            AppStrings.lastDescription,
            style: AppTextStyles.finalDescription
                .copyWith(fontSize: 16 * ratio),
          )

        ],
      ),
    );
  }

  List<Widget> buildLastIcons(double ratio, List<IconData> icons) {

    return List.generate(icons.length,
            (index) => Icon(icons[index], color: Colors.white70, size: 22 * ratio));

  }

}

import 'package:flutter/material.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/url_launcher.dart';
import '../../../data/models/contact_section_model.dart';
import 'section_header.dart';

class ContactSection extends StatefulWidget {

  const ContactSection({super.key}); // _contactKey is directly assigned

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> with TickerProviderStateMixin {

  /// Controllers for arrow slide and fade animation
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _animations;

  // for fade animation in the same AnimationController values range
  late final List<Animation<double>> _fadeAnimations;

  // ValueNotifier to start arrow animation
  late final ValueNotifier<int> _currentIndex;
  // ValueNotifier to highlight last icons when mouse pointer is hovered
  late final ValueNotifier<int> _iconIndex;

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
                // Interval() to fit multiple animation in one controller values range
                // starts and finishes fade animation from 0% to 50% of the controller values range
                curve: const Interval(0.0, 0.5, curve: Curves.easeIn)
            )
            )
    ).toList();
    
    _currentIndex = ValueNotifier(4);
    _iconIndex = ValueNotifier(4);

  }

  @override
  void dispose() {
    // must dispose
    for(final c in _controllers){
      c.dispose();
    }
    _currentIndex.dispose();
    _iconIndex.dispose();
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


  /// For Desktop
  Widget buildDesktopLayout(double width) {

    final ratio = (width / AppBreakpoints.desktop).clamp(0.5, 1.0);

    return Column(
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          SectionHeader(
              ratio: ratio,
              sectionNumber: AppStrings.contactSectionNumber,
              sectionTitle: AppStrings.contactSectionHeading,
              isContactSection: true
          ),
          const SizedBox(height: 60),
          buildGrid(
              ratio: ratio,
              horizontal: 60,
              childAspectRatio: 1.4 * ratio
          ),
          const SizedBox(height: 60),
          buildBottomBar(ratio: ratio)
        ]
    );

  }


  /// For Tablet
  Widget buildTabletLayout(double width) {

    final ratio = (width / AppBreakpoints.tablet).clamp(0.5, 1.0);

    return Column(
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          SectionHeader(
              ratio: ratio,
              sectionNumber: AppStrings.contactSectionNumber,
              sectionTitle: AppStrings.contactSectionHeading,
              isContactSection: true
          ),
          const SizedBox(height: 60), // 40 for mobile
          buildGrid(
              ratio: ratio,
              horizontal: 40,
              childAspectRatio: 1.0 * ratio
          ),
          const SizedBox(height: 60),
          buildBottomBar(ratio: ratio)
        ]
    );

  }


  /// For mobile
  Widget buildMobileLayout(double width) {

    final ratio = (width / AppBreakpoints.mobile).clamp(0.5, 1.0);

    return Column(
        crossAxisAlignment: .center,
        mainAxisSize: .min,
        children: [
          SectionHeader(
              ratio: ratio,
              sectionNumber: AppStrings.contactSectionNumber,
              sectionTitle: AppStrings.contactSectionHeading,
              isContactSection: true
          ),
          const SizedBox(height: 40),
          buildListForMobile(
              ratio: ratio,
              horizontal: 24,
          ),
          const SizedBox(height: 60),
          buildBottomBar(ratio: ratio, isMobile: true)
        ]
    );

  }


  /// build grid for showing 3 contact infos
  Widget buildGrid({required double ratio, required double horizontal, required double childAspectRatio}) {

    return GridView.builder(
        shrinkWrap: true,
        padding: .symmetric(horizontal: horizontal * ratio),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 30 * ratio,
            mainAxisSpacing: 40 * ratio,
            childAspectRatio: childAspectRatio,
        ),
        itemCount: ContactSectionModel.contacts.length,
        itemBuilder: (BuildContext context, int index) {

          final model = ContactSectionModel.contacts[index];

          return mouseRegionForContacts(
            index: index,
            child: ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (BuildContext context, int value, Widget? child) {
                return buildContactContainer(
                    ratio: ratio,
                    model: model,
                    animation: _animations[index],
                    fadeAnimation: _fadeAnimations[index],
                    isHovered: value == index
                );
              }
            ),
          );

        }
    );

  }


  /// build bottom bar for all three layouts
  Container buildBottomBar({required double ratio, bool isMobile = false}) {
    return Container(
      width: double.maxFinite,
      padding: .only( top: 30 * ratio, bottom: (isMobile ? 30 : 20) * ratio),
      alignment: .center,
      color: AppColors.skillContainer,
      child: Column(
        mainAxisSize: .min,
        children: [
          Text(
            AppStrings.lastTitle,
            style: AppTextStyles.finalTitle
                .copyWith(fontSize: (isMobile ? 22 : 18) * ratio),
          ),
          SizedBox(height: 10 * ratio),
          Row(
            spacing: 25 * ratio,
            mainAxisAlignment: .center,
            children: buildLastIcons(
                ratio,
                [
                  Icons.mail_outline_rounded,
                  Icons.code_rounded,
                  Icons.terminal_rounded,
                ],
                isMobile
            )
          ),
          SizedBox(height: (isMobile ? 30 : 20 ) * ratio),
          Padding(   /// Might need to work on this for spacing on the left
            padding: .only(left: isMobile ? 40.0 * ratio : 0),
            child: Text(
              AppStrings.lastDescription,
              style: AppTextStyles.finalDescription
                  .copyWith(fontSize: (isMobile? 22 : 18) * ratio),
            ),
          )

        ],
      ),
    );
  }

  // build last icons for buildBottomBar()
  List<Widget> buildLastIcons(double ratio, List<IconData> icons, bool isMobile) {

    return List.generate(
        icons.length,
            (index) =>
                MouseRegion(
                  onEnter: (event) {
                    _iconIndex.value = index;
                  },
                  onExit: (event) {
                    _iconIndex.value = 4;
                  },
                  child: InkWell(
                    onTap: () {},// url launcher
                    child: ValueListenableBuilder(
                      valueListenable: _iconIndex,
                      builder: (context, value, child) {
                        return Icon(
                            icons[index],
                            color: value == index ? AppColors.primaryColor : Colors.white70,
                            size: (isMobile? 32 : 28) * ratio
                        );
                      }
                    ),
                  ),
                )
    );

  }


  /// build list of contact info for Mobile layout
  Widget buildListForMobile({required double ratio, required double horizontal}) {

    return ListView.separated(
        shrinkWrap: true,
        padding: .symmetric(horizontal: horizontal * ratio),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ContactSectionModel.contacts.length,
        itemBuilder: (BuildContext context, int index) {

          final model = ContactSectionModel.contacts[index];

          return mouseRegionForContacts(
            index: index,
            child: ValueListenableBuilder(
                valueListenable: _currentIndex,
                builder: (BuildContext context, int value, Widget? child) {
                  return buildContactContainer(
                      ratio: ratio,
                      model: model,
                      animation: _animations[index],
                      fadeAnimation:  _fadeAnimations[index],
                      isHovered: value == index,
                      isMobile: true
                  );
                }
            ),
          );

        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 25),
    );

  }

  // build mouse region on contact infos for buildGrid() and buildListForMobile()
  Widget mouseRegionForContacts({required int index, required Widget child }) {

    return MouseRegion(
        onEnter: (event) {
          _controllers[index].forward();
          _currentIndex.value = index;
        },
        onExit: (event) {
          _controllers[index].reverse();
          _currentIndex.value = 4;
        },
        child: InkWell(
            onTap: () => UrlLauncher.openContacts(index), // url launcher
            child: child
        )
    );

  }

  // build contact info containers for buildGrid() and buildListForMobile()
  Widget buildContactContainer({
    required double ratio,
    required ContactSectionEntity model,
    required Animation<Offset> animation,
    required Animation<double> fadeAnimation,
    required bool isHovered,
    bool isMobile = false
  }) {

    return Container(
      alignment: .center,
      height: isMobile ? 400 * ratio : null,
      padding: .symmetric(horizontal: 24 * ratio, vertical:  24 * ratio),
      decoration: BoxDecoration(
          color: AppColors.skillContainer,
          borderRadius: BorderRadius.circular(4)
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          SizedBox(height: isMobile ? null :  40 * ratio),
          buildIcon(ratio ,model, isHovered, isMobile),
          SizedBox(height: (isMobile? 35 : 25) * ratio),
          Text(
            model.title,
            style: AppTextStyles.contactTitle
                .copyWith(fontSize: isMobile? 26 : 24 * ratio), // checking needed for later
          ),
          SizedBox(height: 8 * ratio),
          Text(
            model.description,
            style: AppTextStyles.contactDescription
                .copyWith(fontSize: (isMobile ? 22 : 20) * ratio), /// Mark old 22 : 20
          ),
          SizedBox(height: 20 * ratio),
          buildTransition(ratio, fadeAnimation, animation, isMobile)
        ],
      ),
    );
  }

  // build icons for each contact info for buildContactContainer()
  Container buildIcon(double ratio,ContactSectionEntity model, bool isHovered, bool isMobile) {
    return Container(
      padding: .symmetric(horizontal: 10 * ratio, vertical: 8 * ratio),
      decoration: BoxDecoration(
          color: isHovered ? AppColors.primaryColor.withAlpha(50) : AppColors.subProjectTag,
          borderRadius: BorderRadius.circular(6)
      ),
      child: Icon(
        model.icon,
        color: isHovered ? AppColors.primaryColor : Colors.white70,
        size: isMobile ? 42 * ratio : 32 * ratio,
      ),
    );
  }

  // build fade and slide transition for the arrow for buildContactContainer()
  FadeTransition buildTransition(double ratio, Animation<double> fadeAnimation, Animation<Offset> animation, bool isMobile) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: animation,
        child: Icon(
          Icons.arrow_forward_rounded,
          color: AppColors.primaryColor,
          size: isMobile ?  30 * ratio : 24 * ratio,
          fontWeight: .w600,
        ),
      ),
    );
  }

}

import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/utils/url_launcher.dart';

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
                curve: const Interval(0.0, 0.5, curve: Curves.easeIn)
            )
            )
    ).toList();
    
    _currentIndex = ValueNotifier(4);
    _iconIndex = ValueNotifier(4);

  }

  @override
  void dispose() {
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
              buildGrid(
                  ratio: ratio,
                  horizontal: 60,
                  childAspectRatio: 1.4 * ratio
              ),
              const SizedBox(height: 60),
              buildBottomBar(ratio, false)
            ]
        )
    );

  }

  Widget buildTabletLayout(double width) {

    final ratio = (width / AppBreakpoints.tablet).clamp(0.5, 1.0);

    return Align(
        alignment: .center,
        child: Column(
            crossAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              buildContactSectionHeader(ratio: ratio, isMobile: false),
              const SizedBox(height: 60), // 40 for mobile
              buildGrid(
                  ratio: ratio,
                  horizontal: 40,
                  childAspectRatio: 1.0 * ratio
              ),
              const SizedBox(height: 60),
              buildBottomBar(ratio, false)
            ]
        )
    );

  }

  Widget buildMobileLayout(double width) {

    final ratio = (width / AppBreakpoints.mobile).clamp(0.5, 1.0);

    return Align(
        alignment: .center,
        child: Column(
            crossAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              buildContactSectionHeader(ratio: ratio, isMobile: true),
              const SizedBox(height: 40),
              buildListForMobile(
                  ratio: ratio,
                  horizontal: 24,
              ),
              const SizedBox(height: 60),
              buildBottomBar(ratio, true)
            ]
        )
    );

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
        SizedBox(
          width: isMobile ? 500 * ratio : null,
          child: Text(
            AppStrings.contactSectionHeading,
            textAlign: TextAlign.center,
            style: AppTextStyles.aboutPrecisionStyle
                .copyWith(fontSize: isMobile ? 34 * ratio : 30 * ratio),
          ),
        ),
      ],
    );

  }

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
              )
          );

        }
    );

  }

  Widget buildContactContainer({
      required double ratio,
      required ContactSectionEntity model,
      required Animation<Offset> animation,
      required Animation<double> fadeAnimation,
      required bool isHovered,
      bool isMobile = false}) {
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
              SizedBox(height: isMobile? 35 * ratio : 25 * ratio),
              Text(
                model.title,
                style: AppTextStyles.contactTitle
                    .copyWith(fontSize: isMobile? 26 : 24 * ratio),
              ),
              SizedBox(height: 8 * ratio),
              Text(
                model.description,
                style: AppTextStyles.contactDescription
                    .copyWith(fontSize: isMobile ? 22 * ratio : 20 * ratio), /// Mark old 22 : 20
              ),
              SizedBox(height: 20 * ratio),
              buildTransition(ratio, fadeAnimation, animation, isMobile)
            ],
          ),
        );
  }

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

  Container buildBottomBar(double ratio, bool isMobile) {
    return Container(
      width: double.maxFinite,
      padding: .only( top: 30 * ratio, bottom: (isMobile ? 30 : 20) * ratio),
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
                .copyWith(fontSize: isMobile ? 22 * ratio : 18 * ratio),
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
                _iconIndex,
                isMobile
            )
          ),
          SizedBox(height: (isMobile ? 30 : 20 ) * ratio),
          Padding(   /// Might need to work on this for spacing on the left
            padding: .only(left: isMobile ? 40.0 * ratio : 0),
            child: Text(
              AppStrings.lastDescription,
              style: AppTextStyles.finalDescription
                  .copyWith(fontSize: isMobile? 22 * ratio : 18 * ratio),
            ),
          )

        ],
      ),
    );
  }

  List<Widget> buildLastIcons(double ratio, List<IconData> icons, ValueNotifier<int> indexNotifier, bool isMobile) {

    return List.generate(icons.length,
            (index) =>
                MouseRegion(
                  onEnter: (event) {
                    indexNotifier.value = index;
                  },
                  onExit: (event) {
                    indexNotifier.value = 4;
                  },
                  child: InkWell(
                    onTap: () {},// url launcher
                    child: ValueListenableBuilder(
                      valueListenable: indexNotifier,
                      builder: (context, value, child) {
                        return Icon(
                            icons[index],
                            color: value == index ? AppColors.primaryColor : Colors.white70,
                            size: isMobile? 32 * ratio : 28 * ratio
                        );
                      }
                    ),
                  ),
                )
    );

  }

  Widget buildListForMobile({required double ratio, required double horizontal}) {

    return ListView.separated(
        shrinkWrap: true,
        padding: .symmetric(horizontal: horizontal * ratio),
        physics: const NeverScrollableScrollPhysics(),
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
              child: InkWell(
                onTap: () => UrlLauncher.openContacts(index), // url launcher
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
              )
          );

        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 25),
    );

  }

}

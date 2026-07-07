import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/utils/asset_paths.dart';
import '../../../core/utils/url_launcher.dart';

class HeroSection extends StatefulWidget {

  // the callback to trigger in HomeScreen to scroll to project section
  final VoidCallback onPressed;

  const HeroSection({
    super.key, // _heroKey is directly assigned no parameter needed
    required this.onPressed
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {

  // List of controllers to show badge floating animation
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;
  // Controller to show available for hires green dot, fade animation
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {

    super.initState();

    // one controller per badge
    _controllers = List.generate(
        3,
        (int index) => AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))
    );

    // each badge bounces by 6 pixels
    _animations = _controllers.map(
        (e) => Tween<double>(
          begin: 0,
          end: -10,
        ).animate(CurvedAnimation(parent: e, curve: Curves.easeInOut))
    ).toList();

    // to show Available for hire green dots fade animation
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    // fades from 100% to 35%
    _fadeAnimation = Tween<double>(begin: 0.35, end: 1)
        .animate(CurvedAnimation(
        parent: _fadeController, curve: Curves.easeInOut
        )
    );

    _fadeController.repeat(reverse: true);

    for(final c in _controllers){
     c.repeat(reverse: true);
    }

  }

  @override
  void dispose() {
    // must dispose controllers
    _fadeController.dispose();

    for(final c in _controllers){
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

  /// Desktop
  Widget buildDesktopLayout(double width) {

    final ratio = (width / AppBreakpoints.desktop).clamp(0.5, 1.0);

    return Padding(
    padding: EdgeInsets.symmetric(horizontal: (60.0 * ratio)), // ratio added
    child: Row(

      children: [
        Expanded(
            flex: 6,
            child: buildTextContent(ratio)
        ),
        const Spacer(),
        Expanded(
          flex: 4,
          child: buildPhotoStack(ratio),
        ),
      ],
    ),
    );
  }

  /// Tablet
  Widget buildTabletLayout(double width) {

    final ratio = (width / AppBreakpoints.desktop).clamp(0.1, 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (40.0 * ratio)), // ratio added
      child: Row(

        children: [
          Expanded(
              flex: 6,
              child: buildTextContent(ratio)
          ),
          const Spacer(),
          Expanded(
              flex: 4,
              child: buildPhotoStack(ratio)
          )
        ],
      ),
    );
  }

  /// Transition between tablet to mobile
  Widget buildMiddleLayout(double width) {

    final ratio = (width / (AppBreakpoints.desktop * 1.1)).clamp(0.1, 1.0);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (60.0 * ratio)), // ratio added
      child: Row(

        children: [
          Expanded(
              flex: 6,
              child: buildTextContent(ratio)
          ),
          const Spacer(),
          Expanded(
              flex: 4,
              child: buildPhotoStack(ratio)
          )
        ],
      ),
    );
  }

  /// Mobile
  Widget buildMobileLayout(double width) {

    final double ratio = (width / AppBreakpoints.mobile).clamp(0.6, 1.0);

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0 * ratio), // ratio added
        child: Column(
          crossAxisAlignment: .start,
          mainAxisSize: .min,
          children: [
            buildTextContent(ratio),
            const SizedBox(height: 32),
            buildPhotoStack(ratio)
          ],
        )
    );

  }

  /// build text content
  Widget buildTextContent(double ratio) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        /// Available for hire badge
        buildAvailableForHire(),
        const SizedBox(height: 25), // dynamic size
        Text(
            AppStrings.greeting,
            style: AppTextStyles.greetingStyle
                .copyWith(fontSize: (62 * ratio)) // ratio added
        ),
        const SizedBox(height: 5), // dynamic size
        Text(
            AppStrings.role,
            style: AppTextStyles.roleStyle
                .copyWith(fontSize: (32 * ratio))
        ),
        const SizedBox(height: 10),
        buildAboutDescriptionText(ratio),
        const SizedBox(height: 20),
        buildButtons(ratio),
        SizedBox(height: 28 * ratio),
        buildIconButtons(ratio)
      ],
    );
  }

  // Available for hire badge for buildTextContent()
  Container buildAvailableForHire() {
    return Container(
        width: 158,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: AppColors.activeContainer,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            buildFadeTransition(
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              AppStrings.hireAvailable,
              style: AppTextStyles.availableStyle,
            ),
          ],
        )
    );
  }

  // Fade transition for buildAvailableForHire()
  Widget buildFadeTransition(Widget child){
    return FadeTransition(
      opacity: _fadeAnimation,
      child: child,
    );
  }

  // build about description text for buildTextContent()
  LayoutBuilder buildAboutDescriptionText(double ratio) {
    return LayoutBuilder(
        builder: (BuildContext context, constraints) {
          final double width = constraints.maxWidth;

          if(width < AppBreakpoints.mobile) {
            return Text(
                AppStrings.descriptionForMobileView,
                style: AppTextStyles.descriptionStyle
                    .copyWith(fontSize: (22 * ratio))
            );
          }

          return Text(
              AppStrings.description,
              style: AppTextStyles.descriptionStyle
                  .copyWith(fontSize: (22 * ratio))
          );
        }
    );
  }

  // build buttons for buildTextContent()
  Row buildButtons(double ratio) {
    return Row(
      children: [
        FilledButton(
          onPressed: widget.onPressed,
          style: FilledButton.styleFrom(
              padding: .symmetric(horizontal: 24 * ratio, vertical: 15 * ratio),
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(4)
              )
          ),
          child: Text(
              AppStrings.viewProjectsButton,
              style: AppTextStyles.resumeButton
                  .copyWith(fontSize: (22 * ratio))
          ),
        ),
        SizedBox(width: 20 * ratio),
        OutlinedButton(
          onPressed: () => UrlLauncher.openGitHub(),
          style: OutlinedButton.styleFrom(
              padding: .symmetric(horizontal: 40 * ratio, vertical: 15 * ratio),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(4),
                  side: BorderSide(width: 1, color: Colors.white)
              )
          ),
          child: Text(
              AppStrings.gitHubButton,
              style: AppTextStyles.gitHubStyle
                  .copyWith(fontSize: (22 * ratio))
          ),
        )
      ],
    );
  }

  // build icon buttons for buildTextContent
  Row buildIconButtons(double ratio) {
    return Row(
      spacing: 5,
      children: [
        buildIconButton(
            ratio,
            Icons.code_rounded,
                () => UrlLauncher.openGitHub()
        ),

        buildIconButton(
            ratio,
            Icons.link_rounded,
                () => UrlLauncher.openLinkedin()
        ),

        buildIconButton(
            ratio,
            Icons.mail_outline_rounded,
                () => UrlLauncher.openMail()
        ),
      ],
    );
  }

  // icon button for buildIconButtons()
  IconButton buildIconButton(double ratio, IconData icon, VoidCallback onTap) =>
      IconButton(onPressed: onTap, icon: Icon(icon, color: Colors.white, size: 30 * ratio));


  /// build photo stack
  Widget buildPhotoStack(double ratio) {

    return Row(
      children: [
        SizedBox(width: 22 * ratio),
        // Floating python badge
        Column(
          mainAxisAlignment: .center,
          children: [
            const SizedBox(height: 30),
            buildAnimation(
              animation: _animations[0],
              child: buildFloatingBadge(
                  icon: Icons.terminal_rounded,
                  color: Colors.orange,
                  label:  AppStrings.pythonBadge,
                  ratio: ratio
              ),
            )
          ],
        ),
        const SizedBox(width: 5), // Edge point
        Stack(
          alignment: .center,
          children: [
            Container(
                width: (330 * ratio),
                height: (315 * ratio),
                alignment: .centerStart,
                child: SvgPicture.asset(
                  AssetPaths.profile,
                  height: (300 * ratio),
                  width: (300 * ratio),
                )
            ),

            Positioned(
                bottom: 0,
                right: 80,
                child: buildAnimation(
                  animation: _animations[1],
                  child: buildFloatingBadge(
                      icon: Icons.storage_rounded,
                      color: AppColors.primaryColor,
                      label: AppStrings.firebaseBadge,
                      ratio: ratio
                  ),
                )
            ),
            Positioned(
              top: 0,
              right: 0,
              child: buildAnimation(
                  animation: _animations[2],
                  child: buildFlutterBadge(ratio)
              ),
            )
          ],
        )
      ],
    );

  }

  // build floating badge for buildPhotoStack()
  Widget buildFloatingBadge({required IconData icon ,required Color color, required String label, required double ratio}) {
    return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.floatingBadge,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.black45,
                  width: 0.2
                )
              ),
              child: Row(
                children: [
                  Icon(icon, color: color, size: (20 * ratio).clamp(5, 20)),
                  const SizedBox(width: 5),
                  Text(
                      label,
                      style: AppTextStyles
                          .badgeStyle.copyWith(fontSize: (13 * ratio).clamp(5, 12))
                  )
                ],
              ),
            );
  }

  // build flutter badge for buildPhotoStack()
  Widget buildFlutterBadge(double ratio) {
    return Card(
      color: Colors.transparent,
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: AppColors.floatingBadge,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Colors.black45,
                width: 0.2
            )
        ),
        child: Row(
          children: [
            FlutterLogo(size: (20 * ratio).clamp(5, 20)),
            const SizedBox(width: 5),
            Text(
                AppStrings.flutterBadge,
                style: AppTextStyles.badgeStyle
                    .copyWith(fontSize: (13 * ratio).clamp(5, 12))
            )
          ],
        ),
      ),
    );
  }

  // build animation for buildPhotoStack() floating badges
  Widget buildAnimation({required Animation<double> animation, required Widget child}) {

    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: child,
        );
      },
      child: child,
    );

  }

}
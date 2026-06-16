import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/utils/asset_paths.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';

class HeroSection extends StatefulWidget {

  final GlobalKey heroKey;
  const HeroSection({super.key, required this.heroKey});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {

  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {

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

    for(final c in _controllers){
      if(mounted) c.repeat(reverse: true);
    }

    super.initState();
  }

  @override
  void dispose() {
    for(final c in _controllers){
      c.dispose();
    }
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Row(
        children: [
          Column(
            key: widget.heroKey,
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
              /// Available for hire badge
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                  color: AppColors.activeContainer,
                  borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                          AppStrings.hireAvailable,
                        style: AppTextStyles.availableStyle,
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 25), // dynamic size
              Text(AppStrings.greeting, style: AppTextStyles.greetingStyle), // dynamic size
              const SizedBox(height: 5), // dynamic size
              Text(AppStrings.role, style: AppTextStyles.roleStyle,), // dynamic size
              const SizedBox(height: 10),
              Text(
                  AppStrings.description,
                style: AppTextStyles.descriptionStyle,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  FilledButton(
                    onPressed: () {}, // url launcher
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(5)
                      )
                    ),
                    child: Text(AppStrings.viewProjectsButton, style: AppTextStyles.resumeButton),
                  ),
                  const SizedBox(width: 20),
                  OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(5),
                          side: BorderSide(width: 1, color: Colors.white)
                        )
                      ),
                      child: Text(AppStrings.gitHubButton, style: AppTextStyles.gitHubStyle),
                  )
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.code_rounded, color: Colors.white)),
                  const SizedBox(width: 5),
                  IconButton(onPressed: () {}, icon: Icon(Icons.link_rounded, color: Colors.white)),
                  const SizedBox(width: 5),
                  IconButton(onPressed: () {}, icon: Icon(Icons.mail_outline_rounded, color: Colors.white))
                ],
              )
            ],
          ),
          const Spacer(),
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
                      label:  AppStrings.pythonBadge
                  ),
              )
            ],
          ),
          const SizedBox(width: 5), // Edge point
          Stack(
            alignment: .center,
            children: [
              Container(
                  width: 330,
                  height: 315,
                  alignment: .centerStart,
                  child: SvgPicture.asset(AssetPaths.profile, height: 300, width: 300,)
              ),

              Positioned(
                bottom: 0,
                right: 80,
                child: buildAnimation(
                  animation: _animations[1],
                  child: buildFloatingBadge(
                      icon: Icons.storage_rounded,
                      color: AppColors.primaryColor,
                      label: AppStrings.firebaseBadge
                  ),
                )
              ),
              Positioned(
                top: 0,
                right: 0,
                child: buildAnimation(
                    animation: _animations[2],
                    child: buildFlutterBadge()
                ),
              )
            ],
          )
        ],
      ),
    );

  }

  Container buildFloatingBadge({required IconData icon ,required Color color, required String label}) {
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
                  Icon(icon, color: color, size: 20),
                  const SizedBox(width: 5),
                  Text(label, style: AppTextStyles.badgeStyle)
                ],
              ),
            );
  }

  Widget buildFlutterBadge() {
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
            FlutterLogo(size: 20),
            const SizedBox(width: 5),
            Text(AppStrings.flutterBadge, style: AppTextStyles.badgeStyle)
          ],
        ),
      ),
    );
  }

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

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class HeroSection extends StatelessWidget {

  final GlobalKey heroKey;
  const HeroSection({super.key, required this.heroKey});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60.0),
      child: Row(
        children: [
          Column(
            key: heroKey,
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            children: [
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
                          'AVAILABLE FOR HIRE',
                        style: AppTextStyles.availableStyle,
                      ),
                    ],
                  )
              ),
              const SizedBox(height: 25), // dynamic size
              Text('Hi, I\'m Nazmul', style: AppTextStyles.greetingStyle), // dynamic size
              const SizedBox(height: 10), // dynamic size
              Text('Flutter Developer', style: AppTextStyles.roleStyle,), // dynamic size
              const SizedBox(height: 10),
              Text(
                  'I build high-performance mobile & web apps with Flutter and\nPython. Passionate about creating seamless user experience and\nefficient backend integrations.',
                style: AppTextStyles.descriptionStyle,
              ),
              const SizedBox(height: 25),
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
                    child: Text('View Projects', style: AppTextStyles.resumeButton),
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
                      child: Text('GitHub', style: AppTextStyles.gitHubStyle),
                  )
                ],
              ),
              const SizedBox(height: 25),
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
          Stack()
        ],
      ),
    );

  }
}

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class DesktopNavBar extends StatefulWidget {

  final ValueChanged<GlobalKey> onNavTap;
  final Map<String, GlobalKey> keys;


  const DesktopNavBar({super.key, required this.onNavTap, required this.keys});

  @override
  State<DesktopNavBar> createState() => _DesktopNavBarState();
}

class _DesktopNavBarState extends State<DesktopNavBar> {

  final ValueNotifier<int> _current = ValueNotifier(0);
  static const List<String> navItems = ['Hero', 'About', 'Skills', 'Projects', 'Contact'];

  @override
  Widget build(BuildContext context) {


    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 48),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),

      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          // Logo
          const Text(
            'NazmulDev',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),


          // Nav links — each calls onNavTap with its specific key
          // _NavLink(
          //   label: 'Hero',
          //   onTap: () => widget.onNavTap(widget.keys['hero']!),
          // ),
          // _NavLink(
          //   label: 'About',
          //   onTap: () => widget.onNavTap(widget.keys['about']!),
          // ),
          // _NavLink(
          //   label: 'Skills',
          //   onTap: () => widget.onNavTap(widget.keys['skills']!),
          // ),
          // _NavLink(
          //   label: 'Projects',
          //   onTap: () => widget.onNavTap(widget.keys['projects']!),
          // ),
          // _NavLink(
          //   label: 'Contact',
          //   onTap: () => widget.onNavTap(widget.keys['contact']!),
          // ),

          const SizedBox(width: 1),

          ListView.builder(
            itemCount: navItems.length,
            padding: EdgeInsets.only(
                top: 20,
                bottom: 0
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,

            itemBuilder: (BuildContext context, int index) {

              return ValueListenableBuilder(
                valueListenable: _current,
                builder: (BuildContext context, int value, child) {
                  return _NavLink(
                      label: navItems[index],
                      isSelected: value == index,
                      onTap: () {
                        _current.value = index;
                        widget.onNavTap(widget.keys[navItems[index].toLowerCase()]!);
                      }
                  );
                }
              );

            },

          ),

          //const SizedBox(width: 300),

          // Resume button
          FilledButton(
            onPressed: () {}, // url_launcher later
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: AppColors.filledButtonColor,
            ),
            child: Text(
                'Download Resume',
              style: AppTextStyles.resumeButton,
            ),
          ),
        ],
      ),

    );

  }
}

// Small reusable nav link widget
class _NavLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const _NavLink({required this.label, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14,
                fontWeight: .bold
              ),
            ),
            const SizedBox(height: 5),
            if(isSelected)
              Container(
                height: 3,
                width: getWidth(label.length) , // 35
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              )
          ],
        ),
      ),
    );
  }

  double getWidth(int labelLength){

    switch(labelLength){

      case 4:
        return 35;
      case 5:
        return 40;
      case 6:
        return 38;
      case 7:
        return 50;
      case 8:
        return 54;
      default:
        return 35;
    }

  }
}
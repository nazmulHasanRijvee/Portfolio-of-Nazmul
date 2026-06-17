import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/media_query_extension.dart';
import '../../../data/models/nav_bar_model.dart';

class DesktopNavBar extends StatefulWidget {

  final ValueChanged<GlobalKey> onNavTap;
  final Map<String, GlobalKey> keys;


  const DesktopNavBar({super.key, required this.onNavTap, required this.keys});

  @override
  State<DesktopNavBar> createState() => _DesktopNavBarState();
}

class _DesktopNavBarState extends State<DesktopNavBar> {

  late final ValueNotifier<int> _current;


  @override
  void initState() {
    super.initState();
    _current = ValueNotifier(0);
  }

  @override
  void dispose() {
    _current.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 48),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 0.8),
        ),
      ),

      child: Row(
        mainAxisAlignment: .center,
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

          SizedBox(width: 50 * (context.sizeOf.width / 1440)),

          const Spacer(),

          buildListView(),

          Spacer(),


          // Resume button
          FilledButton(
            onPressed: () {
              debugPrint('Resume button pressed ${context.sizeOf.width}');
            }, // url_launcher later
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

  ListView buildListView() {
    return ListView.separated(
          itemCount: NavBarModel.navItems.length,
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

                final String navItem = NavBarModel.navItems[index];

                return _NavLink(
                    label: navItem,
                    isSelected: value == index,
                    onTap: () {
                      _current.value = index;
                      widget.onNavTap(widget.keys[navItem.toLowerCase()]!);
                    }
                );
              }
            );

          },

          separatorBuilder: (BuildContext context, int index) {

            return const SizedBox(width: 10);

          }

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
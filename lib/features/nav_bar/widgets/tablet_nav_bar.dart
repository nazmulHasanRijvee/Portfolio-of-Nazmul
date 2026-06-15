import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/constants/app_breakpoints.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/media_query_extension.dart';

class TabletNavBar extends StatefulWidget {

  final ValueChanged<GlobalKey> onNavTap;
  final Map<String, GlobalKey> keys;


  const TabletNavBar({super.key, required this.onNavTap, required this.keys});

  @override
  State<TabletNavBar> createState() => _TabletNavBarState();
}

class _TabletNavBarState extends State<TabletNavBar> {

  late final ValueNotifier<int> _current;
  static const List<String> navItems = ['Hero', 'About', 'Skills', 'Projects', 'Contact'];

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

    final double ratio = context.sizeOf.width / AppBreakpoints.tablet;
    final double secondRatio = context.sizeOf.width / (AppBreakpoints.tablet * 0.7);

    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 38 * ratio),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 0.6),
        ),
      ),

      child: Row(
        mainAxisAlignment: .center,
        children: [
          // Logo
          Text(
            'NazmulDev',
            style: TextStyle(
              color: AppColors.white,
              fontSize: (18 * secondRatio).clamp(11, 18),
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(width: 25 * ratio),

          const Spacer(),

          buildListView(),

          Spacer(),


          // Resume button
          FilledButton(
            onPressed: () {
              debugPrint('Resume button pressed ${context.sizeOf.width}');
            }, // url_launcher later
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10 * ratio, horizontal: 10 * ratio),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: AppColors.filledButtonColor,
            ),
            child: Text(
              'Download Resume',
              style: AppTextStyles.resumeButton.copyWith(fontSize: 14 * ratio)
            ),
          ),
        ],
      ),

    );

  }

  ListView buildListView() {
    return ListView.builder(
        itemCount: navItems.length,
        padding: EdgeInsets.only(
            top: 20,
            bottom: 0,
            left: 0,
            right: 0
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

    final double ratio = context.sizeOf.width / (AppBreakpoints.tablet * 0.7);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: .min,
          children: [
            Text(
              label,
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: (14 * ratio).clamp(11, 14),
                  fontWeight: .bold
              ),
            ),
            const SizedBox(height: 5),
            if(isSelected)
              Container(
                height: 3,
                width: getWidth(label.length, ratio) , // 35
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

  double getWidth(int labelLength, double ratio){

    switch(labelLength){

      case 4:
        return 35 * ratio;
      case 5:
        return 40 * ratio;
      case 6:
        return 38 * ratio;
      case 7:
        return 50 * ratio;
      case 8:
        return 54 * ratio;
      default:
        return 35 * ratio;
    }

  }
}
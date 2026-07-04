import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/constants/app_breakpoints.dart';
import 'package:flutter7_portfolio/core/utils/url_launcher.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/media_query_extension.dart';
import '../../../data/models/nav_bar_model.dart';
import 'nav_link.dart';

class TabletNavBar extends StatefulWidget {

  final ValueChanged<GlobalKey> onNavTap;
  final Map<String, GlobalKey> keys;


  const TabletNavBar({super.key, required this.onNavTap, required this.keys});

  @override
  State<TabletNavBar> createState() => _TabletNavBarState();
}

class _TabletNavBarState extends State<TabletNavBar> {

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

    final double ratio = (context.sizeOf.width / AppBreakpoints.tablet * 1.2)
        .clamp(0.1, 1.0);
    final double secondRatio = (context.sizeOf.width / (AppBreakpoints.tablet * 0.7))
        .clamp(0.1, 1.0);

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
          Text(
            AppStrings.appTitle,
            style: AppTextStyles.navBarAppTitle
                .copyWith(fontSize: 18 * secondRatio)
          ),

          SizedBox(width: 25 * ratio),

          const Spacer(),

          buildListView(ratio,secondRatio),

          Spacer(),

          // Resume button
          FilledButton(
            onPressed: openResume,
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10 * ratio, horizontal: 10 * ratio),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              backgroundColor: AppColors.filledButtonColor,
            ),
            child: Text(
              AppStrings.downloadResume,
              style: AppTextStyles.resumeButton.copyWith(fontSize: 16 * (ratio / 1.1)) /// needs work nav items are much larger
            ),
          ),
        ],
      ),

    );

  }

  ListView buildListView(double ratio, double secondRatio) {
    return ListView.builder(
      itemCount: NavBarModel.navItems.length,
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

        final String navItem = NavBarModel.navItems[index];

        return ValueListenableBuilder(
            valueListenable: _current,
            builder: (BuildContext context, int value, child) {
              return NavLink(
                label: navItem,
                isSelected: value == index,
                onTap: () => onNavLinkTap(index, navItem),
                secondRatio: secondRatio,
                ratio: ratio,
              );
            }
            );
        },

    );
  }

  void openResume() {
    // debugPrint('Resume button pressed ${context.sizeOf.width}');
    UrlLauncher.openResume();
  }

  void onNavLinkTap(int index, String navItem){
    _current.value = index;
    widget.onNavTap(widget.keys[navItem.toLowerCase()]!);
  }
}


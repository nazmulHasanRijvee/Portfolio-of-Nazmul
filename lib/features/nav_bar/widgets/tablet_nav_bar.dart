import 'package:flutter/material.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/media_query_extension.dart';
import '../../../data/models/nav_bar_model.dart';
import 'nav_link.dart';
import 'resume_button.dart';

class TabletNavBar extends StatefulWidget {

  final Function(GlobalKey, String) onNavTap;
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
        border: const Border(
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

          const Spacer(),

          // Resume button
          ResumeButton(
            ratio: ratio,
            isTablet: true,
          )
        ],
      ),

    );

  }

  ListView buildListView(double ratio, double secondRatio) {
    return ListView.builder(
      itemCount: NavBarModel.navItems.length,
      padding: const EdgeInsets.only(
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

  void onNavLinkTap(int index, String navItem){
    _current.value = index;
    widget.onNavTap(widget.keys[navItem.toLowerCase()]!, navItem);
  }
}


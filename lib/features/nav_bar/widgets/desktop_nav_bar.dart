import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/constants/app_breakpoints.dart';
import 'package:flutter7_portfolio/features/nav_bar/widgets/resume_button.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/media_query_extension.dart';
import '../../../core/utils/url_launcher.dart';
import '../../../data/models/nav_bar_model.dart';
import 'nav_link.dart';

class DesktopNavBar extends StatefulWidget {

  final Function(GlobalKey, String) onNavTap;
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

    final double ratio = (context.sizeOf.width / AppBreakpoints.desktop).clamp(0.1, 1.1);


    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 48),
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.95),
        border: const Border(
          bottom: BorderSide(color: AppColors.border, width: 0.8),
        ),
      ),

      child: Row(
        mainAxisAlignment: .center,
        children: [
          // Logo
          Text(
            AppStrings.appTitle,
            style: AppTextStyles.navBarAppTitle
                .copyWith(fontSize: 18 ) // ratio here
          ),

          SizedBox(width: 50 * ratio),

          const Spacer(),

          buildListView(),

          const Spacer(),

          // Resume button
          const ResumeButton()
        ],
      ),

    );

  }

  ListView buildListView() {
    return ListView.separated(
        itemCount: NavBarModel.navItems.length,
        padding: const EdgeInsets.only(
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

                return NavLink(
                    label: navItem,
                    isSelected: value == index,
                    onTap: () => onNavLinkTap(index, navItem)
                    );
              }
              );

          },

          separatorBuilder: (BuildContext context, int index) {

            return const SizedBox(width: 10);

          }

          );
  }

  void openResume() {
    // debugPrint('Resume button pressed ${context.sizeOf.width}');
    UrlLauncher.openResume();
  }

  void onNavLinkTap(int index, String navItem){
    _current.value = index;
    widget.onNavTap(widget.keys[navItem.toLowerCase()]!, navItem);
  }

}

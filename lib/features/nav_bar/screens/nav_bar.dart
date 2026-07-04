import 'package:flutter/material.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../widgets/desktop_nav_bar.dart';
import '../widgets/mobile_nav_bar.dart';
import '../widgets/tablet_nav_bar.dart';

class NavBar extends StatelessWidget {

  // State hoisting, defining callbacks to control logic in home screen
  final ValueChanged<GlobalKey> onPressed;
  final Map<String, GlobalKey> keys;

  const NavBar({
    super.key,
    required this.onPressed,
    required this.keys
  });

  @override
  Widget build(BuildContext context) {


    return LayoutBuilder(
        builder: (context, constraints){

          final width = constraints.maxWidth;

          if(width < AppBreakpoints.mobile){
            // for mobile
            return MobileNavBar(onNavTap: onPressed, keys: keys);

          } else if (width < AppBreakpoints.tablet){
            // for tablet
            return TabletNavBar(onNavTap: onPressed, keys: keys);

          } else {
            // for desktop
            return DesktopNavBar(onNavTap: onPressed, keys: keys);

          }

        }
    );

  }

}
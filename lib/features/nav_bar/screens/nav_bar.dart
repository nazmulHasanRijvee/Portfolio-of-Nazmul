import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/constants/app_breakpoints.dart';
import 'package:flutter7_portfolio/features/nav_bar/widgets/desktop_nav_bar.dart';

class NavBar extends StatelessWidget {

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

          if(constraints.maxWidth >= AppBreakpoints.tablet){

            return DesktopNavBar(onNavTap: onPressed, keys: keys);

          }

           return DesktopNavBar(onNavTap: onPressed, keys: keys);

        }
    );

  }

}
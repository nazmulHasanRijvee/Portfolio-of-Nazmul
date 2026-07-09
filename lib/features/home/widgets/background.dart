import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/asset_paths.dart';

class Background extends StatelessWidget {

  // The widget sub tree to show on the background
  final Widget child;

  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              AssetPaths.background,
              fit: BoxFit.cover,
            ),
          ),
          child
        ],
      ),
    );
  }
}

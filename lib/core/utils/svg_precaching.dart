import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgPrecaching {

  static Future<void> precacheSvgAssets(List<String> assetPaths) async {
    await Future.wait(
      assetPaths.map(_warmSvgCache).toList()
    );
  }

  static Future<void> _warmSvgCache(String assetPath) async {
    try {
      final loader = SvgAssetLoader(assetPath);
      await svg.cache.putIfAbsent(
        loader.cacheKey(null),
            () => loader.loadBytes(null),
      );
    } catch (error, stackTrace) {
      debugPrint('SVG precache failed: $assetPath\n$error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

}
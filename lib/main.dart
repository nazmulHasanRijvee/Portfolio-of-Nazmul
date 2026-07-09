import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/firebase_options.dart';

import 'core/theme/app_theme.dart';
import 'core/utils/asset_paths.dart';
import 'core/utils/svg_precaching.dart';
import 'features/home/screens/home_screen.dart';


void main() async {

  // Make sure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);

  // Precache Svgs
  await SvgPrecaching.precacheSvgAssets([
    AssetPaths.profile,
    AssetPaths.background
  ]).timeout(
      const Duration(seconds: 2),
      onTimeout: () => debugPrint('SVG precache timed out')
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NazmulDev',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen() // web doesn't support initialRoute:
    );
  }
}

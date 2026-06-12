import 'package:flutter/material.dart';

import 'core/constants/app_theme.dart';
import 'features/home/screens/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      //initialRoute: HomeScreen.routeName,
      home: const HomeScreen()
    );
  }
}

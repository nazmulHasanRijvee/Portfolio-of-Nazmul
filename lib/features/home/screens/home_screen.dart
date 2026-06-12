import 'package:flutter/material.dart';

import '../../../core/constants/app_text_styles.dart';
import '../../nav_bar/screens/nav_bar.dart';

class HomeScreen extends StatefulWidget{

  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // Step 2: ScrollController for the page
  final ScrollController _scrollController = ScrollController();

  // Step 3: The scroll function — this is what NavBar calls
  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;  // finds the widget in the tree
    if (context == null) return;         // guard — if widget not built yet

    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      alignment: 0.0, // 0.0 = top of viewport, 0.5 = center
    );
  }

  @override
  void dispose() {
    _scrollController.dispose(); // always dispose!
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Column(

        children: [

          NavBar(
            onPressed: _scrollToSection,
            keys: {
              'hero': _heroKey,
              'about': _aboutKey,
              'skills': _skillsKey,
              'projects': _projectsKey,
              'contact': _contactKey,
            },
          ),

          Expanded(

            child: SingleChildScrollView(
              controller: _scrollController,

              child: SizedBox(
                width: double.infinity,
                child: Column(

                  children: [

                    const SizedBox(height: 150),

                    Text(
                    'Hero section',
                      key: _heroKey,
                      style: AppTextStyles.testStyle,
                    ),

                    const SizedBox(height: 150),

                    Text(
                        'About Section',
                      key: _aboutKey,
                      style: AppTextStyles.testStyle,
                    ),

                    const SizedBox(height: 150),

                    Text(
                      'Skills Section',
                      key: _skillsKey,
                      style: AppTextStyles.testStyle,
                    ),

                    const SizedBox(height: 150),

                    Text(
                        'Projects Section',
                      key: _projectsKey,
                      style: AppTextStyles.testStyle,
                    ),

                    const SizedBox(height: 150),

                    Text(
                        'Contact Section',
                      key: _contactKey,
                      style: AppTextStyles.testStyle,
                    )

                  ]
                ),
              ),
            )
          )

        ],

      ),

    );

  }
}
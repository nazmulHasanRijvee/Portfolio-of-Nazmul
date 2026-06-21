import 'package:flutter/material.dart';
import 'package:flutter7_portfolio/core/extensions/media_query_extension.dart';
import 'package:flutter7_portfolio/features/home/widgets/about_section.dart';
import 'package:flutter7_portfolio/features/home/widgets/hero_section.dart';
import 'package:flutter7_portfolio/features/home/widgets/skill_section.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../../nav_bar/screens/nav_bar.dart';
import '../widgets/background.dart';
import '../widgets/contact_section.dart';
import '../widgets/project_section.dart';

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

    return Background(

      child: Column(

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
                width: context.sizeOf.width,
                child: Column(

                  children: [

                    LayoutBuilder(
                      builder: (BuildContext context, constraints) {
                        final double width = constraints.maxWidth;
                        if(width < AppBreakpoints.mobile) {
                          return const SizedBox(height: 30);
                        } else if (width < AppBreakpoints.tablet) {
                          return const SizedBox(height: 130);
                        }
                        return const SizedBox(height: 150);
                      }
                    ),

                    HeroSection(
                        key: _heroKey,
                        onPressed: () => _scrollToSection(_projectsKey),
                    ),

                    const SizedBox(height: 150),

                    AboutSection(key: _aboutKey),

                    const SizedBox(height: 150),

                    SkillSection(key: _skillsKey),

                    const SizedBox(height: 150),

                    ProjectSection(key: _projectsKey),

                    const SizedBox(height: 150),

                    // Text(
                    //     'Contact Section',
                    //   key: _contactKey,
                    //   style: AppTextStyles.testStyle,
                    // )
                    ContactSection(key: _contactKey),

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
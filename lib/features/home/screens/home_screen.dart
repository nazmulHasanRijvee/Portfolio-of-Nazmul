import 'package:flutter/material.dart';

import '../../../core/constants/app_breakpoints.dart';
import '../../../core/extensions/media_query_extension.dart';
import '../../nav_bar/screens/nav_bar.dart';
import '../widgets/about_section.dart';
import '../widgets/background.dart';
import '../widgets/contact_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/project_section.dart';
import '../widgets/skill_section.dart';

class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late final GlobalKey _heroKey;
  late final GlobalKey _aboutKey;
  late final GlobalKey _skillsKey;
  late final GlobalKey _projectsKey;
  late final GlobalKey _contactKey;

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
  void initState() {
    super.initState();
    _heroKey = GlobalKey();
    _aboutKey = GlobalKey();
    _skillsKey = GlobalKey();
    _projectsKey = GlobalKey();
    _contactKey = GlobalKey();
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
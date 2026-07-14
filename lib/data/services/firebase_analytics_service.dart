import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;


  Future<void> logStartup() async {
    await _analytics.logEvent(
      name: 'app_opened',
    );
  }

  Future<void> logSectionViewed(String sectionName) async {

    await _analytics.logEvent(
      name: 'section_viewed',
      parameters: {
        'section_name': sectionName,
      },
    );

  }

  Future<void> logSocialLink(String socialLink) async {

    await _analytics.logEvent(
      name: 'social_link_clicked',
      parameters: {
        'social_link': socialLink,
      },
    );

  }

  Future<void> logResumeClicked() async {
    await _analytics.logEvent(
      name: 'resume_clicked',
    );
  }

  Future<void> logProjectClicked(String project) async {
    await _analytics.logEvent(
      name: 'project_clicked',
      parameters: {
        'project_name': project,
      },
    );
  }

}
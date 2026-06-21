import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {

  static Future<void> openUrl(String url) async {

    final uri = Uri.parse(url);
    if(await canLaunchUrl(uri)){
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }

  }

  // Helper methods
  static Future<void> openGitHub() =>
      openUrl('https://github.com/nazmulHasanRijvee');

  static Future<void> openLinkedin() =>
      openUrl('https://www.linkedin.com/in/nazmul-hasan-rijvee');

  static Future<void> openMail() =>
      openUrl('https://mail.google.com/mail/u/0/?fs=1&to=nhasanr18@gmail.com&su=SUBJECT&body=BODY&tf=cm');

  static Future<void> openResume() =>  // updated the link every time you update CV
  openUrl('https://drive.google.com/file/d/1zxBn7I9jHtkGPi7qNGiYbdRTbysj9hz4/view?usp=sharing');

  static Future<void> openLLMApp () =>
      openUrl('https://github.com/nazmulHasanRijvee/LLM-Based-Chat-Bot-App.git');

  static Future<void> openSubproject(int index) async {
    switch(index){
      case 0:
      openUrl('https://github.com/nazmulHasanRijvee/Local-Event-Finder.git');
      case 1:
        openUrl('https://github.com/nazmulHasanRijvee/Task-Manager-App.git');
      case 2:
        openUrl('https://github.com/nazmulHasanRijvee/Crafty-Bay.git');
      default:
        debugPrint('Error index is: $index');
    }
  }

  static Future<void> openContacts(int index) async {
    switch(index){
      case 0:
        openUrl('https://github.com/nazmulHasanRijvee');
      case 1:
        openUrl('https://www.linkedin.com/in/nazmul-hasan-rijvee');
      case 2:
        openUrl('https://mail.google.com/mail/u/0/?fs=1&to=nhasanr18@gmail.com&su=SUBJECT&body=BODY&tf=cm');
      default:
        debugPrint('Error index is: $index');
    }
  }



  static Future<void> openLocalEvent () =>
      openUrl('https://github.com/nazmulHasanRijvee/Local-Event-Finder.git');

  static Future<void> openTaskManager () =>
      openUrl('https://github.com/nazmulHasanRijvee/Task-Manager-App.git');

  static Future<void> openCraftyBay () =>
      openUrl('https://github.com/nazmulHasanRijvee/Crafty-Bay.git');

}
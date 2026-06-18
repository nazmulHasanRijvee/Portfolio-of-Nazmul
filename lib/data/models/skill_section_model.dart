import 'package:flutter/material.dart';

class SkillSectionModel {

  static final List<SkillSectionEntity> skillModels = [

    SkillSectionEntity(
        label: 'Flutter',
        icon: Icons.phone_android_rounded,
        skills: ['Widgets', 'Animations', 'Responsive UI']
    ),
    SkillSectionEntity(
      label: 'Dart',
      icon: Icons.code_rounded,
      skills: ['Async/Await', 'Generics', 'Null Safety']
    ),
    SkillSectionEntity(
        label: 'State Mgmt',
        icon: Icons.autorenew_outlined,
        skills: ['Provider', 'Riverpod', 'GetX']
    ),
    SkillSectionEntity(
        label: 'Architecture',
        icon: Icons.layers_outlined,
        skills: [ 'MVVM', 'get_it', 'Bindings',]
    ),
    SkillSectionEntity(
      label: 'Firebase',
      icon: Icons.cloud_queue_rounded,
      skills: ['Auth', 'Storage', 'Firestore']
    ),
    SkillSectionEntity(
        label: 'REST APIs',
        icon: Icons.electric_bolt_rounded,
        skills: ['HTTP', 'Dio', 'JSON']
    ),
    SkillSectionEntity(
        label: 'Local Storage',
        icon: Icons.storage_rounded,
        skills: ['Hive', 'Shared Preferences', 'Caching']
    ),
    SkillSectionEntity(
        label: 'Git & Tools',
        icon: Icons.account_tree_outlined,
        skills: ['GitHub', 'CI/CD', 'Version Control']
    ),

  ];

}

class SkillSectionEntity {

  final String label;
  final IconData icon;
  final List<String> skills;

  SkillSectionEntity({required this.label, required this.icon, required this.skills});

}
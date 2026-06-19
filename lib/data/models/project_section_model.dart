import '../../core/utils/asset_paths.dart';

class ProjectSectionModel {

  static final projectOne = ProjectSectionEntity(
    title: 'LLM-Based Chat & Image-Gen App',
    description: 'A full-scale AI powered Flutter application with multi-model'
        ' LLM chat-bot and image generation via OpenRouter API. Features interactive '
        'chat interface, smooth animations, auto scrolling & clean architecture.',
    tags: ['Flutter', 'Provider', 'OpenRouter'],
    imageUrl: 'assets/images/pr1.png'
  );


  static final List<ProjectSectionEntity> bottomProjects = [
    ProjectSectionEntity(
      title: 'Local Event Finder',
      description: 'A Flutter app designed to help users discover events happening in'
          ' their local area using Google Maps',
      tags: ['Flutter', 'Google Maps', 'GetX'],
      imageUrl: AssetPaths.projectThree
    ),
    ProjectSectionEntity(
      title: 'Task Manager',
      description: 'Task Manager is a Flutter-based '
          'productivity app focused on scalability,'
          ' secure authentication & backend integration',
      tags: ['Dart', 'JWT-Auth', 'REST APIs'],
      imageUrl: AssetPaths.projectTwo
    ),
    ProjectSectionEntity(
      title: 'Crafty Bay',
      description: 'An e-commerce app built using Flutter show casing real-world'
          'logic like cart state, product listings and pagination',
      tags: ['Provider', 'Flutter', 'Pagination'],
      imageUrl: AssetPaths.projectFour
    )
  ];


}

class ProjectSectionEntity {

  final String title;
  final String description;
  final List<String> tags;
  final String imageUrl;

  ProjectSectionEntity({
    required this.title,
    required this.description,
    required this.tags,
    required this.imageUrl,

  });

}
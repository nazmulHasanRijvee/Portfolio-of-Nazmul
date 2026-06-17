class AboutSectionModel {

  static final List<AboutSectionEntity> aboutData = [

    AboutSectionEntity(
      title: '6+',
      subTitle: 'PROJECTS'
    ),
    AboutSectionEntity(
        title: '1 Yr',
        subTitle: 'TRAINING'
    ),
    AboutSectionEntity(
        title: 'Dhaka',
        subTitle: 'BD'
    )

  ];

}

class AboutSectionEntity {

  final String title;
  final String subTitle;

  AboutSectionEntity({required this.title, required this.subTitle});

}
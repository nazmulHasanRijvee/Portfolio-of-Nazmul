import 'package:flutter/material.dart';

class ContactSectionModel {

  static final List<ContactSectionEntity> contacts = [
    ContactSectionEntity(
        icon: Icons.terminal_rounded,
        title: 'GitHub',
        description: '@nazmulHasanRijvee'
    ),
    ContactSectionEntity(
        icon: Icons.link_rounded,
        title: 'LinkedIn',
        description: 'MD Nazmul Hasan'
    ),
    ContactSectionEntity(
        icon: Icons.mail_outline_rounded,
        title: 'Email',
        description: 'nhasanr18@gmail.com'
    ),
  ];

}

class ContactSectionEntity {

  final IconData icon;
  final String title;
  final String description;

  ContactSectionEntity({required this.icon, required this.title, required this.description});
  

}
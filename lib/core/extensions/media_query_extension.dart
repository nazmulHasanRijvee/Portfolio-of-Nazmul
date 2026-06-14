import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get sizeOf => MediaQuery.sizeOf(this);

}
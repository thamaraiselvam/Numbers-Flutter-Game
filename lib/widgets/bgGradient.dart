import 'package:flutter/material.dart';
import 'package:numbers/utils/constants.dart';

BoxDecoration bgBoxDecoration() {
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
        primaryColor,
        secondaryColor
      ]));
}

import 'package:flutter/material.dart';

BoxDecoration bgBoxDecoration() {
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
        Color.fromRGBO(40, 20, 130, 1),
        Color.fromRGBO(206, 127, 216, 1)
      ]));
}

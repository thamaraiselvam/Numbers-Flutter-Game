import 'package:flutter/material.dart';

BoxDecoration bgBoxDecoration() {
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
        Color.fromRGBO(66, 39, 90, 1),
        Color.fromRGBO(115, 75, 109, 1)
      ]));
}

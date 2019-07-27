import 'package:flutter/material.dart';

ListTile titleWiget() {
  return ListTile(
    isThreeLine: true,
    title: Text(
      'NUMBERS',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Container(
      child: Text(
        'Problem Solving',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontSize: 11, fontStyle: FontStyle.italic),
      ),
    ),
  );
}

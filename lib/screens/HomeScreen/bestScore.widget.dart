import 'package:flutter/material.dart';

ListTile buildBestScore(int bestScore) {
  return ListTile(
    leading: Icon(
      Icons.golf_course,
      size: 40,
      color: Colors.white,
    ),
    title: Text(
      'Best Score',
      style: TextStyle(color: Colors.white, fontSize: 13),
    ),
    subtitle: Text(
      bestScore.toString(),
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}

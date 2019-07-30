import 'package:flutter/material.dart';

class BestScore extends StatelessWidget {
  const BestScore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        '55590',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}

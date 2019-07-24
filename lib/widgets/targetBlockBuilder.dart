import 'package:flutter/material.dart';

Container buildTargetBlock({String title, int targetValue}) {
  return Container(
    width: 280,
    height: 100,
    alignment: Alignment(0.0, 0.0),
    child: Column(
      children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          targetValue.toString(),
          style: TextStyle(
              color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    ),
    decoration: BoxDecoration(
        color: Color.fromRGBO(17, 38, 33, 0.5),
        borderRadius: new BorderRadius.circular(10)),
  );
}

import 'package:flutter/material.dart';

Container buildNumberBlocks() {
  return Container(
    // alignment: Alignment.centerLeft,
    alignment: Alignment(0.0, 0.0),
    // color: Colors.grey,
    padding: const EdgeInsets.all(30),
    child: Wrap(
      spacing: 40,
      runSpacing: 40,
      children: <Widget>[
        numberBlock(Colors.white, Colors.yellow, 4),
        numberBlock(Colors.white, Colors.red, 9),
        numberBlock(Colors.white, Colors.blue, 1),
        numberBlock(Colors.white, Colors.yellow, 1),
        numberBlock(Colors.white, Colors.red, 1),
        numberBlock(Colors.white, Colors.blue, 1),
      ],
    ),
  );
}

Container numberBlock(Color borderColor, Color bgColor, int value) {
  return Container(
    width: 120,
    height: 120,
    alignment: Alignment(0.0, 0.0),
    decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor, width: 5),
        borderRadius: new BorderRadius.circular(10)),
    child: Text(
      value.toString(),
      style: TextStyle(
          color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
    ),
  );
}

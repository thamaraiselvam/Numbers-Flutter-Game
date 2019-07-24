import 'dart:async';

import 'package:flutter/material.dart';

Container buildNumberBlocks(NumberCreater numberCreater) {
  return Container(
    // alignment: Alignment.centerLeft,
    alignment: Alignment(0.0, 0.0),
    // color: Colors.grey,
    padding: const EdgeInsets.all(30),
    child: Wrap(
      spacing: 40,
      runSpacing: 40,
      children: <Widget>[
        numberBlock(numberCreater, Colors.white, Colors.yellow, 1),
        numberBlock(numberCreater, Colors.white, Colors.red, 3),
        numberBlock(numberCreater, Colors.white, Colors.blue, 4),
        numberBlock(numberCreater, Colors.white, Colors.yellow, 2),
        numberBlock(numberCreater, Colors.white, Colors.red, 10),
        numberBlock(numberCreater, Colors.white, Colors.blue, 9),
      ],
    ),
  );
}

Widget numberBlock(NumberCreater numberCreater, Color borderColor, Color bgColor, int value) {
  bool isSelected = false;
  return Material(
    child: InkWell(
      onTap: () {
        isSelected = isSelected ? false : true;
        print(isSelected);
        bgColor = Colors.red;
        print(bgColor);
        numberCreater.setCount(value);
      }, // handle your onTap here
      child: Container(
        width: 120,
        height: 120,
        alignment: Alignment(0.0, 0.0),
        decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor, width: 5),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          value.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
        ),
        // child: ,
      ),
    ),
  );
}

class NumberCreater {
  var _count = 1;

  void setCount(int count){
    this._count = count;
    _controller.sink.add(count);
  }

  final _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;
}

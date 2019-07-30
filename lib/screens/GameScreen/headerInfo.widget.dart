import 'package:flutter/material.dart';
import 'package:numbers/utils/constants.dart';

Row headerInfo(int secCounter, Map<String, int> gameHistory) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
          padding: const EdgeInsets.only(left: 15, right: 10),
          width: 100,
          color: blackLowOpacity,
          child: Row(
            children: <Widget>[
              Text(
                'TIMER : ',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                secCounter.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
      Container(
          margin: const EdgeInsets.only(left: 10),
          padding: const EdgeInsets.only(left: 15, right: 10),
          // width: 200,
          color: blackLowOpacity,
          child: Row(
            children: <Widget>[
              Text(
                'SCORE : ',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                gameHistory['score'].toString(),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ))
    ],
  );
}

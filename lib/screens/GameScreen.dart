import 'dart:async';
import 'package:add_numbers/widgets/bgGradient.dart';
import 'package:add_numbers/widgets/numberBlockBuilder.dart';
import 'package:add_numbers/widgets/targetBlockBuilder.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  NumberCreater numberCreater = NumberCreater();

  @override
  void initState() {
    super.initState();
    numberCreater.stream.listen((data) {
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SafeArea(
      child: Scaffold(
        body: Container(
          decoration: bgBoxDecoration(),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              buildTargetBlock(title: 'Target', targetValue: 6),
              SizedBox(
                height: 6,
              ),
              buildNumberBlocks(numberCreater)
            ],
          ),
        ),
      ),
    ));
  }
}

import 'package:add_numbers/widgets/bgGradient.dart';
import 'package:add_numbers/widgets/numberBlockBuilder.dart';
import 'package:add_numbers/widgets/targetBlockBuilder.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
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
              buildTargetBlock(title: 'Target', targetValue: 19),
              SizedBox(
                height: 6,
              ),
              buildNumberBlocks()
            ],
          ),
        ),
      ),
    ));
  }
}

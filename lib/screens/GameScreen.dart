import 'package:add_numbers/widgets/bgGradient.dart';
import 'package:add_numbers/provider/BlockDataStream.dart';
import 'package:add_numbers/widgets/targetBlockBuilder.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  NumberCreater numberCreater = NumberCreater();

  List blocks = getBlocks();

  @override
  void initState() {
    super.initState();
    numberCreater.stream.listen((data) {
      setState(() {
        if (this.blocks[data].color != Colors.green) {
          this.blocks[data].color = Colors.green;
        }
      });
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
              buildNumberBlocks()
            ],
          ),
        ),
      ),
    ));
  }

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
          _numberBlock(
              bgColor: this.blocks[0].color, value: this.blocks[0].value),
          _numberBlock(
              bgColor: this.blocks[1].color, value: this.blocks[1].value),
          _numberBlock(
              bgColor: this.blocks[2].color, value: this.blocks[2].value),
          _numberBlock(
              bgColor: this.blocks[3].color, value: this.blocks[3].value),
          _numberBlock(
              bgColor: this.blocks[4].color, value: this.blocks[4].value),
          _numberBlock(
              bgColor: this.blocks[5].color, value: this.blocks[5].value),
        ],
      ),
    );
  }

  Widget _numberBlock({Color borderColor, Color bgColor, int value}) {
    bool isSelected = false;
    return Material(
      child: InkWell(
        onTap: () {
          isSelected = isSelected ? false : true;
          numberCreater.setCount(value);
        }, // handle your onTap here
        child: Container(
          width: 120,
          height: 120,
          alignment: Alignment(0.0, 0.0),
          decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: Colors.white, width: 5),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            value.toString(),
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class Block {
  Color color;
  int value;
  int index;
  Block(this.color, this.value);
}

List<Block> getBlocks() {
  return [
    new Block(Colors.yellow, 0),
    new Block(Colors.red, 1),
    new Block(Colors.blue, 2),
    new Block(Colors.yellow, 3),
    new Block(Colors.red, 4),
    new Block(Colors.blue, 5)
  ];
}

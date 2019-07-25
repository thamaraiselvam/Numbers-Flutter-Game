import 'package:add_numbers/schema/blackSchema.dart';
import 'package:add_numbers/widgets/bgGradient.dart';
import 'package:add_numbers/provider/BlockDataStream.dart';
import 'package:add_numbers/widgets/targetBlockBuilder.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  BlockDataStream blockDataStream = BlockDataStream();

  BlockSchema blockSchema;
  List<BlockSchema> blocks;

  int currentTotal;

  @override
  void initState() {
    super.initState();
    this.fillBlocksData();
    this.listenBlockChanges();
  }

  void fillBlocksData() {
    setState(() {
      this.currentTotal = 0;
      this.blockSchema = BlockSchema();
      this.blocks = blockSchema.getBlocks();
    });
  }

  void listenBlockChanges() {
    blockDataStream.stream.listen((Map<String, int> blockData) {
      setState(() {
        _validateBlocks(blockData);
      });
    });
  }

  void _validateBlocks(blockData) {
    int selectedIndex = blockData['index'];

    if (this.blocks[selectedIndex].isSelected) {
      return;
    }

    this.blocks[selectedIndex].isSelected = true;

    this.currentTotal += blockData['value'];

    if (this.currentTotal < this.blockSchema.target) {
      changeBlockColor(selectedIndex, Colors.green);
      if (!isThereChanceToMakeItCorrect()) {
        _wrongAnswer(selectedIndex);
        return;
      }
    } else if (this.currentTotal == this.blockSchema.target) {
      _correctAnswer(selectedIndex);
    } else {
      _wrongAnswer(selectedIndex);
    }
  }

  void _wrongAnswer(selectedIndex) {
    changeBlockColor(selectedIndex, Colors.red);
    _showStatusAlert('Wrong !!!', Icons.clear, Colors.red, false);
  }

  void _correctAnswer(selectedIndex) {
    changeBlockColor(selectedIndex, Colors.green);
    _showStatusAlert('Correct !!!', Icons.check, Colors.green, true);
  }

  bool isThereChanceToMakeItCorrect() {
    bool chance = false;

    for (var i = 0; i < this.blocks.length; i++) {
      if (this.blocks[i].isSelected) {
        continue;
      }

      if (this.currentTotal + this.blocks[i].value <= this.blockSchema.target) {
        chance = true;
      }
    }

    return chance;
  }

  void changeBlockColor(selectedIndex, Color color) {
    this.blocks[selectedIndex].color = color;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: bgBoxDecoration(),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              buildTargetBlock(
                  title: 'Target', targetValue: this.blockSchema.target),
              SizedBox(
                height: 6,
              ),
              buildNumberBlocks()
            ],
          ),
        ),
      ),
    );
  }

  Container buildNumberBlocks() {
    return Container(
      // alignment: Alignment.centerLeft,
      alignment: Alignment(0.0, 0.0),
      // color: Colors.grey,
      padding: const EdgeInsets.all(30),
      child: Wrap(spacing: 40, runSpacing: 40, children: _generateBlocks(6)),
    );
  }

  List<Widget> _generateBlocks(int size) {
    List<Widget> blocks = [];

    for (var i = 0; i < size; i++) {
      blocks.add(_numberBlock(
          bgColor: this.blocks[i].color,
          index: this.blocks[i].index,
          value: this.blocks[i].value));
    }

    return blocks;
  }

  Future<void> _showStatusAlert(
      String title, IconData icon, Color color, bool isSuccess) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          content: SingleChildScrollView(
            child: Center(
              child: Icon(
                icon,
                color: color,
                size: 100,
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Solve Another one',
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                fillBlocksData();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _numberBlock(
      {Color borderColor, Color bgColor, int index, int value}) {
    bool isSelected = false;
    return Material(
      child: InkWell(
        onTap: () {
          isSelected = isSelected ? false : true;
          blockDataStream.setCount(index: index, value: value);
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

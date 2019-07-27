import 'dart:async';
import 'package:numbers/schema/blackSchema.dart';
import 'package:numbers/utils/constants.dart';
import 'package:numbers/widgets/bgGradient.dart';
import 'package:numbers/provider/BlockDataStream.dart';
import 'package:numbers/widgets/targetBlockBuilder.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  BlockSchema blockSchema;
  List<BlockSchema> blocks;
  int currentTotal;
  Timer gameTimerObject;
  int secCounter = 30;
  bool isTimeUp = false;
  Map<String, int> gameHistory = {"total": 0, "success": 0, "fail": 0};
  BlockDataStream blockDataStream = BlockDataStream();

  @override
  void initState() {
    super.initState();
    this.initTimer();
    this.fillBlocksData();
    this.listenBlockChanges();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: bgBoxDecoration(),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                _headerInfo(),
                SizedBox(
                  height: 10,
                ),
                buildTargetBlock(
                    title: 'Target', targetValue: this.blockSchema.target),
                buildNumberBlocks()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void initTimer() {
    this.gameTimerObject = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        this.secCounter--;
        if (this.secCounter < 1) {
          this.isTimeUp = true;
          this.gameTimerObject.cancel();
          _showSummary();
        }
      });
    });
  }

  void fillBlocksData() {
    if (this.isTimeUp) {
      return;
    }
    setState(() {
      this.gameHistory['total']++;
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
      _changeBlockColor(selectedIndex, Colors.green);
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
    this.gameHistory['fail']++;
    _changeBlockColor(selectedIndex, Colors.red);
    _showStatusAlert('Wrong !!!', Icons.clear, Colors.red, false);
    _closePopUpAndShuffle();
  }

  void _correctAnswer(selectedIndex) {
    this.gameHistory['success']++;
    _changeBlockColor(selectedIndex, Colors.green);
    _showStatusAlert('Correct !!!', Icons.check, Colors.green, true);
    _closePopUpAndShuffle();
  }

  void _closePopUpAndShuffle() {
    Timer(Duration(seconds: 1), () {
      if (this.isTimeUp) {
        return;
      }
      Navigator.of(context).pop();
      fillBlocksData();
    });
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

  void _changeBlockColor(selectedIndex, Color color) {
    this.blocks[selectedIndex].color = color;
  }

  Row _headerInfo() {
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
                  this.secCounter.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
        Container(
            margin: const EdgeInsets.only(left: 10),
            padding: const EdgeInsets.only(left: 15, right: 10),
            width: 100,
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
                  this.gameHistory['success'].toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ))
      ],
    );
  }

  Container buildNumberBlocks() {
    return Container(
      // alignment: Alignment.centerLeft,
      alignment: Alignment(0.0, 0.0),
      // color: Colors.grey,
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Wrap(spacing: 40, runSpacing: 40, children: _generateBlocks(6)),
      ),
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
          backgroundColor: Colors.white.withOpacity(0),
          content: Container(
            width: 100,
            height: 100,
            child: Icon(
              icon,
              color: color,
              size: 100,
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSummary() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Score: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        Text(
                          this.gameHistory['success'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        alignment: Alignment.center,
                        icon: Icon(Icons.home),
                        iconSize: 40,
                        color: Colors.blue,
                        tooltip: 'Home',
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/home', (Route<dynamic> route) => false);
                        },
                      ),
                      IconButton(
                        alignment: Alignment.center,
                        icon: Icon(Icons.refresh),
                        iconSize: 40,
                        color: Colors.green,
                        tooltip: 'Restart',
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/loading', (Route<dynamic> route) => false);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
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

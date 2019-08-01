import 'dart:async';
import 'package:numbers/service/leaderboardService.dart';
import 'package:numbers/store/BestScore.dart';
import 'package:numbers/store/RecentScoreStore.dart';
import 'package:numbers/schema/BlockSchema.dart';
import 'package:numbers/screens/GameScreen/summaryModel.dart';
import 'package:numbers/utils/Config.dart';
import 'package:numbers/widgets/bgGradient.dart';
import 'package:numbers/provider/BlockDataStream.dart';
import 'package:flutter/material.dart';
import 'headerInfo.widget.dart';
import 'numberBlocks.widget.dart';
import 'targetBlock.widget.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  BlockSchema blockSchema;
  List<BlockSchema> blocks;
  int currentTotal;
  Timer gameTimerObject;
  int secCounter = gameDuration;
  bool isTimeUp = false;
  Map<String, int> gameHistory = {
    "total": 0,
    "success": 0,
    "fail": 0,
    "score": 0,
    "selectedBlocks": 0,
    "tmpSelectedBlocks": 0
  };
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
                headerInfo(this.secCounter, this.gameHistory),
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
          this.postGameWorks();
        }
      });
    });
  }

  void postGameWorks() {
    this.isTimeUp = true;
    this.gameTimerObject.cancel();
    showSummary(context, gameHistory);
    updateScores();
  }

  void calculateScore() {
    int score = (this.gameHistory['selectedBlocks'] * costs['block']) +
        (this.gameHistory['success'] * costs['success']) +
        (this.gameHistory['fail'] * costs['fail']);
    this.gameHistory['score'] = score > 0 ? (score) : 0;
  }

  void updateScores() {
    RecentScoreStore().updateRecentScore(gameHistory['score']);
    BestScoreStore().updateScore(gameHistory['score']);
    leaderboardService().setData(gameHistory);
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

    this.gameHistory['tmpSelectedBlocks']++;

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
    this.gameHistory['tmpSelectedBlocks'] = 0; //reset
    calculateScore();
    _changeBlockColor(selectedIndex, Colors.red);
    _showStatusAlert('Wrong !!!', Icons.clear, Colors.red, false);
    _closePopUpAndShuffle();
  }

  void _correctAnswer(selectedIndex) {
    this.gameHistory['success']++;
    this.gameHistory['selectedBlocks'] += this.gameHistory['tmpSelectedBlocks'];
    this.gameHistory['tmpSelectedBlocks'] = 0; //reset
    calculateScore();
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
      blocks.add(numberBlock(
          bgColor: this.blocks[i].color,
          index: this.blocks[i].index,
          value: this.blocks[i].value,
          blockDataStream: this.blockDataStream));
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
}

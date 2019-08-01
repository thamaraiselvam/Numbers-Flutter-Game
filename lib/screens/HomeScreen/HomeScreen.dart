import 'package:flutter/material.dart';
import 'package:numbers/component/LeaderboardCard.dart';
import 'package:numbers/component/RecentScoreCard.dart';
import 'package:numbers/store/BestScoreStore.dart';
import 'package:numbers/store/SettingsStore.dart';
import 'package:numbers/utils/Common.dart';
import 'package:numbers/utils/constants.dart';
import 'package:numbers/widgets/dashedLine.dart';

import 'appTitle.widget.dart';
import 'bestScore.widget.dart';
import 'tutorialBtn.widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bestScore = 0;

  @override
  void initState() {
    super.initState();
    this.setBestScore();
  }

  void setBestScore() async {
    int _bestScore = await BestScoreStore().getBestScore();
    setState(() {
      this.bestScore = _bestScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: secondaryBGColor,
        body: SingleChildScrollView(
          child: Container(
            color: primaryColorLowOpacity,
            child: Column(
              children: <Widget>[
                Container(
                  color: primaryColorLowOpacity,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      titleWiget(),
                      SizedBox(
                        height: 40,
                      ),
                      buildBestScore(this.bestScore),
                      dashedLineBreak(Colors.white),
                      SizedBox(
                        height: 10,
                      ),
                      TutorialWidget(),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                LeaderboardCard(),
                RecentScoreBoard(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            this.floatingBtnAction();
          },
          child: Icon(Icons.play_arrow),
          backgroundColor: primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void floatingBtnAction() async {
    String name = await SettingsStore().getKey('name');

    if (name != null) {
      return this.navigateToGame();
    }

    _asyncNameDialog(context);
  }

  Future<String> _asyncNameDialog(BuildContext context) async {
    String name = '';
    return showDialog<String>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter your name'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Name', hintText: 'eg. Thamaraiselvam'),
                onChanged: (value) {
                  name = value;
                },
              ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Randamize'),
              onPressed: () {
                String name = Common.getRandomName();
                this.saveName(name);
                this.navigateToGame();
              },
            ),
            FlatButton(
              child: Text('Save'),
              onPressed: () {
                this.saveName(name);
                this.navigateToGame();
              },
            ),
          ],
        );
      },
    );
  }

  void saveName(String name){
    SettingsStore().setKey('name', name);
  }

  void navigateToGame() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/loading', (Route<dynamic> route) => false);
  }
}

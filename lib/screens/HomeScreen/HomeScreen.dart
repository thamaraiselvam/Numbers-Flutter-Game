import 'package:flutter/material.dart';
import 'package:numbers/component/LeaderboardCard.dart';
import 'package:numbers/component/RecentScoreCard.dart';
import 'package:numbers/store/BestScore.dart';
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
                // SizedBox(
                //   height: 10,
                // ),
                LeaderboardCard(),
                RecentScoreBoard(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/loading', (Route<dynamic> route) => false);
          },
          child: Icon(Icons.play_arrow),
          backgroundColor: primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

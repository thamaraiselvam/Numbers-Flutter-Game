import 'package:flutter/material.dart';
import 'package:numbers/component/ScoreCard.dart';
import 'package:numbers/utils/constants.dart';
import 'package:numbers/widgets/dashedLine.dart';

import 'appTitle.widget.dart';
import 'bestScore.widget.dart';
import 'tutorialBtn.widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                      BestScore(),
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
                SizedBox(
                  height: 10,
                ),
                ScoreBoard('Recent Scores'),
                // ScoreBoard('recent_score '),
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

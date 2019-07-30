import 'package:flutter/material.dart';
import 'package:numbers/store/RecentScoreStore.dart';
import 'package:numbers/utils/constants.dart';
import 'package:numbers/widgets/dashedLine.dart';
import 'package:numbers/widgets/recentScore.dart';

class ScoreBoard extends StatefulWidget {
  final String title;
  ScoreBoard(this.title);

  @override
  _ScoreBoardState createState() => _ScoreBoardState();
}

class _ScoreBoardState extends State<ScoreBoard> {
  List recentScore = [];
  Map scoreCardMeta = {};
  @override
  void initState() {
    super.initState();
    _getRecentScore();
  }

  void _getRecentScore() {
    RecentScoreStore().getRecentScore().then((score) {
      setState(() {
        this.recentScore = score;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryBGColor,
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.show_chart,
                    color: primaryColor,
                  ),
                  title: Text(widget.title,
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold)),
                ),
                dashedLineBreak(Colors.grey),
                (this.recentScore.length == 0)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('No data found, Play some games'),
                      )
                    : buildTableRow(this.recentScore),
                SizedBox(
                  height: 15,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:numbers/service/leaderboardService.dart';
import 'package:numbers/utils/constants.dart';
import 'package:numbers/widgets/dashedLine.dart';
import 'package:numbers/widgets/leadershipBoardTable.dart';

class LeaderboardCard extends StatefulWidget {
  _LeaderboardCardState createState() => _LeaderboardCardState();
}

class _LeaderboardCardState extends State<LeaderboardCard> {
  String title= 'Leaderboard';
  List scores = [];

  @override
  void initState() {
    super.initState();
    _getRecentScore();
  }

  void _getRecentScore() {
    leaderboardService().getData().then((score) {
      setState(() {
        this.scores = score;
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
                  title: Text(title,
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold)),
                ),
                dashedLineBreak(Colors.grey),
                (this.scores.length == 0)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('No data found, Play some games'),
                      )
                    : leaderboardTable(this.scores),
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

import 'package:flutter/material.dart';
import 'package:numbers/utils/constants.dart';
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
                      ListTile(
                        isThreeLine: true,
                        title: Text(
                          'NUMBERS',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Container(
                          child: Text(
                            'Problem Solving',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.golf_course,
                          size: 40,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Best Score',
                          style: TextStyle(color: Colors.white, fontSize: 13),
                        ),
                        subtitle: Text(
                          '55590',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      _dashedLineBreak(Colors.white),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: primaryColor,
                          onPressed: () {
                            Navigator.of(context).pushNamed('/howTo');
                          },
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.help,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                ' HOW TO PLAY',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _scoreBoard('Recent Scores'),
                _scoreBoard('Leaderboard '),
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

  Container _scoreBoard(String title) {
    return Container(
      child: Column(
        children: <Widget>[
          Card(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.show_chart,
                    color: primaryColor,
                  ),
                  title: Text(title,
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold)),
                ),
                _dashedLineBreak(Colors.grey),
                ListTile(
                  leading: Text(
                    '12',
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing:
                      Text('22 hr Ago', style: TextStyle(color: greyFontColor)),
                ),
                ListTile(
                  leading: Text(
                    '12',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing:
                      Text('22 hr Ago', style: TextStyle(color: Colors.black)),
                ),
                ListTile(
                  leading: Text(
                    '12',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing:
                      Text('22 hr Ago', style: TextStyle(color: Colors.black)),
                ),
                ListTile(
                  leading: Text(
                    '12',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing:
                      Text('22 hr Ago', style: TextStyle(color: Colors.black)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _dashedLineBreak(Color color) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 10.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}

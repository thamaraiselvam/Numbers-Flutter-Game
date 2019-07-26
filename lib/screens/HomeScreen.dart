import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.only(top: 20),
          color: Color.fromRGBO(78, 218, 100, 1),
          child: Column(
            children: <Widget>[
              Card(
                color: Colors.transparent,
                child: Column(
                  children: <Widget>[
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
                      subtitle: Text(
                        'Improve Problem Solving Skills',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontStyle: FontStyle.italic),
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
                    _dashedLineBreak(),
                    ListTile(
                      leading: Icon(Icons.flag, size: 40, color: Colors.white),
                      title: Text(
                        'Best Rank',
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                      subtitle: Text(
                        'GRADUATE',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      trailing: Icon(
                        Icons.info,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      color: Colors.transparent,
                      onPressed: () {
                        Navigator.of(context).pushNamed('/howTo');
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: Icon(
                          Icons.schedule,
                          color: Colors.white,
                        ),
                        title: Text(
                          'HOW TO PLAY',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.transparent,
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.show_chart,
                              color: Colors.white,
                            ),
                            title: Text('Recent Scores',
                                style: TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            leading: Text(
                              '12',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text('22 hr Ago',
                                style: TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            leading: Text(
                              '12',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text('22 hr Ago',
                                style: TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            leading: Text(
                              '12',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text('22 hr Ago',
                                style: TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            leading: Text(
                              '12',
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: Text('22 hr Ago',
                                style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/loading', (Route<dynamic> route) => false);
          },
          child: Icon(Icons.play_arrow),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  _dashedLineBreak() {
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
                decoration: BoxDecoration(color: Colors.white),
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

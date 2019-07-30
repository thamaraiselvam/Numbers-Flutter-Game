import 'package:flutter/material.dart';

Future<void> showSummary(BuildContext context, Map<String, int> gameHistory, ) async {
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
                          gameHistory['score'].toString(),
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

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'GameScreen.dart';

class LoadingScreen extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  Color _color = Colors.green;
  int _startCounter = 3;
  Timer _timer;
  Random random = Random();

  @override
  void initState() {
    super.initState();
    this.runCounter();
  }

  void runCounter() {
    Duration oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_startCounter < 1) {
                timer.cancel();
                return;
              }

              _color = Color.fromRGBO(random.nextInt(256), random.nextInt(256),
                  random.nextInt(256), 1);
              _startCounter--;
            }));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            alignment: Alignment(0.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _startCounter.toString(),
                  style: TextStyle(
                      fontSize: 50, color: _color, fontWeight: FontWeight.w600),
                ),
                Text(
                  'GET READY',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600),
                ),
                RaisedButton(
                  child: Text('Start'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GameScreen()),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

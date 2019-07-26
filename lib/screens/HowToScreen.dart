import 'package:flutter/material.dart';

class HowToScreen extends StatelessWidget {
  const HowToScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('HOW TO PLAY'),
          centerTitle: false,
        ),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: 30,
              ),
              color: Colors.cyan,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/numbers_game_play.gif'),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Card(
                  margin: EdgeInsets.only(top: 20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Match the target shown at the top by adding one or more number blocks',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/loading', (Route<dynamic> route) => false);
          },
          backgroundColor: Colors.green,
          icon: Icon(Icons.play_arrow),
          label: Text("PLAY GAME"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

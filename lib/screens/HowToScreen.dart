import 'package:flutter/material.dart';
import 'package:numbers/utils/constants.dart';

class HowToScreen extends StatelessWidget {
  const HowToScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('HOW TO PLAY'),
          backgroundColor: primaryColor,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(
                  top: 30,
                ),
                color: secondaryColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/numbers_game_play.gif'),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      margin: EdgeInsets.only(top: 20),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Match the target shown at the top by adding one or more number blocks.',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40,)
                ],
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/loading', (Route<dynamic> route) => false);
          },
          backgroundColor: primaryColor,
          icon: Icon(Icons.play_arrow),
          label: Text("PLAY GAME"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

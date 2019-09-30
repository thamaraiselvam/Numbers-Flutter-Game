import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:numbers/models/userModel/user_model.dart';
import 'package:numbers/service/googleSignIn.dart';

Size size = Size(0, 0);
TextEditingController phone = new TextEditingController();

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  bool check = true;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: google(),
            )
          ],
        ),
      ),
    );
  }

  Widget google() {
    MediaQueryData queryData = MediaQuery.of(context);
    return RaisedButton(
      onPressed: () async {
        final user = await signInWithGoogle();
        User().fromJson({
          "name": user.displayName,
          "phone": '12345',
          "email": user.email,
          "userID": user.uid,
        });
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/game', (Route<dynamic> route) => false);
      },
      child: Container(
        alignment: Alignment.center,
        height: queryData.size.height / 14,
        width: queryData.size.width / 1.52,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset(
                "images/gvector.png",
                height: queryData.size.height / 26,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 27.0),
            ),
            Text(
              'Sign in with Google',
              textAlign: TextAlign.center,
              style: TextStyle(fontFamily: "Product Sans"),
            ),
          ],
        ),
      ),
      animationDuration: Duration(seconds: 3),
      highlightElevation: 20.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    );
  }
}

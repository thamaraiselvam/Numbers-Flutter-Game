import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:numbers/screens/SplashScreen.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Splash screen test', (WidgetTester tester) async {
    SplashScreen splashScreen = SplashScreen();

    await tester.pumpWidget(makeTestableWidget(child: splashScreen));

    expect(find.text('Numbers'), findsOneWidget);
    print('Found the first text widget.');

    print('\nSplash screen test successful.');
  });
}

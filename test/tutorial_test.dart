import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import '../lib/screens/TurorialScreen.dart';

//Match the target shown at the top by adding one or more number blocks.

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Tutorial screen test', (WidgetTester tester) async {
    TurorialScreen turorialScreen = TurorialScreen();

    await tester.pumpWidget(makeTestableWidget(child: turorialScreen));

    expect(find.text('Match the target shown at the top by adding one or more number blocks.'), findsOneWidget);
    print('Found the text widget.');

    print('\nTutorial screen test successful.');
  });
}

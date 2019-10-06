import 'dart:math';
import 'package:flutter_test/flutter_test.dart';

import 'package:numbers/utils/Common.dart';

void main() {

  List<int> combinations;

  test('Find Combination Test', () {
    combinations = Common.findCombination(12, 2);

    expect(combinations.length, 2);
    print('Length is correct');

    expect(combinations.reduce((a, b) => a + b), 12);
    print('Sum is correct');

    print('\nFind Combination Test successful.');
  });

  test('Fill With Random Values Test', (){
    List<int> randomList = Common.fillWithRandomValues(combinations, 35, 6);

    expect(randomList.length, 6);
    print('Length is correct');

    expect(randomList.reduce(max) <= 35, true);
    print('Max is correct');

    expect(randomList.reduce(min) >= 0, true);
    print('Min is correct');

    print('\nFill With Random Values Test successful.');
  });
}

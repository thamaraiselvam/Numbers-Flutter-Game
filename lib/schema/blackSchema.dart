import 'package:numbers/utils/common.dart';
import 'package:flutter/material.dart';

class BlockSchema {

  int value, index, target ;
  bool isSelected = false;
  Color color;
  final int size = 6;
  List<int> blockValues;

  BlockSchema(){
    this.generateTargetValue();
    this.generateValues();
  }

  void generateTargetValue(){
    this.target = Common.getRandomNumber(min: 4, max: 25);
  }

  void generateValues(){
    List<int> combinations = Common.findCombination(this.target, 3);
    this.blockValues = Common.fillWithRandomValues(combinations, this.target * 2, size);
  }

  BlockSchema.build({this.color, this.index, this.value});

  List<BlockSchema> getBlocks() {

    List<BlockSchema> blocksList = [];

    for (var i = 0; i < this.size; i++) {
      blocksList.add(new BlockSchema.build(color: Common.getRandomColor(), index: i, value: this.blockValues[i]),);
    }

    return blocksList;
  }
}

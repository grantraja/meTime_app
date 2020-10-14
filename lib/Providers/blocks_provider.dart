import 'package:flutter/material.dart';
import '../tools/timeOfDay_tools.dart';
import '../Models/block.dart';

class Blocks with ChangeNotifier {
  List<Block> _blocks = [
    Block(
      name: "Test",
      start: TimeOfDay(hour: 5, minute: 30),
      end: TimeOfDay(hour: 7, minute: 30),
      days: [false, true, true, true, true, true, false],
    )
  ];

  bool validateNewTimes(Block newBlock) {
    //Times are fine till conflict is found
    bool valid = true;
    //check ever current block
    _blocks.forEach((evalBlock) {
      //are there overlapping times?
      if (isConflicting(
          evalBlock.start, evalBlock.end, newBlock.start, newBlock.end)) {
        //if so, are there also overlapping days?
        for (int i = 0; i < 7; i++) {
          if (evalBlock.days[i] == true && newBlock.days[i] == true) {
            //if it passes both previous questions, the timing is invaild
            valid = false;
          }
        }
      }
    });
    return valid;
  }

  bool addBlock(Block newBlock) {
    if (!validateNewTimes(newBlock)) {
      return false;
    }
    _blocks.add(newBlock);
  }

  List<int> todaysBlocks(int day) {
    List<int> results = [];
    for (int i = 0; i < _blocks.length; i++) {
      if (_blocks[i].days[day] = true) {
        results.add(i);
      }
    }
    return results;
  }

  Block findById(int id) {
    return _blocks[id];
  }
}

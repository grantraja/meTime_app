import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import '../tools/timeOfDay_tools.dart';
import '../Models/block.dart';

// import '../helpers/db_helper.dart';

class BlocksProvider with ChangeNotifier {
  List<Block> _blocks = [
    Block(
      id: 0,
      title: "Test",
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
    print("Add block validate");
    if (!validateNewTimes(newBlock)) {
      return false;
    }
    newBlock.id = _blocks.length;
    //Pushing to Provider
    _blocks.add(newBlock);
    //Updating UI
    notifyListeners();
    print("Block added to provider, listeners notified");
    //Pushing to database Storage
    //Provider.of<DBHelper>(context).insertMap();
    // DBHelper.insert(DBHelper.tableNames[0], {
    //   'id': newBlock.id,
    //   'title': newBlock.title,
    //   'strtH': newBlock.start.hour,
    //   'strtM': newBlock.start.minute,
    //   'endH': newBlock.end.hour,
    //   'endM': newBlock.end.minute,
    //   'd1': newBlock.days[0] ? 1 : 0,
    //   'd2': newBlock.days[1] ? 1 : 0,
    //   'd3': newBlock.days[2] ? 1 : 0,
    //   'd4': newBlock.days[3] ? 1 : 0,
    //   'd5': newBlock.days[4] ? 1 : 0,
    //   'd6': newBlock.days[5] ? 1 : 0,
    //   'd7': newBlock.days[6] ? 1 : 0,
    //   'group': null,
    // });
    return true;
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

  // Future<void> initialize() async {
  //   final dataList = await DBHelper.getData(DBHelper.tableNames[0]);
  //   _blocks = dataList
  //       .map(
  //         (item) => Block(
  //           id: item['id'],
  //           title: item['title'],
  //           start: TimeOfDay(hour: item['strtH'], minute: item['strtM']),
  //           end: TimeOfDay(hour: item['endH'], minute: item['endM']),
  //           days: [
  //             item['d1'] == 1 ? true : false,
  //             item['d2'] == 1 ? true : false,
  //             item['d3'] == 1 ? true : false,
  //             item['d4'] == 1 ? true : false,
  //             item['d5'] == 1 ? true : false,
  //             item['d6'] == 1 ? true : false,
  //             item['d7'] == 1 ? true : false,
  //           ],
  //         ),
  //       )
  //       .toList();
  //   notifyListeners();
  // }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../tools/timeOfDay_tools.dart';
import '../Models/block.dart';
import './db_provider.dart';
import '../helpers/db_helper.dart';

class BlocksProvider with ChangeNotifier {
  Database blocksDatabase;
  List<Block> _blocks = [
    Block(
      id: 0,
      title: "Test",
      start: TimeOfDay(hour: 5, minute: 30),
      end: TimeOfDay(hour: 7, minute: 30),
      days: [false, true, true, true, true, true, false],
    )
  ];

  Future<void> loadData(BuildContext context) async {
    print("Blocks Provider: Load Data Called");
    //new db code
    final String dbName = "BlocksProvider.db";
    final String dbPath = await getDatabasesPath() + dbName;
    print("Blocks Provider: Database Name: $dbName");
    print("Blocks Provider: Database Path: $dbPath");
    blocksDatabase = await openDatabase(dbPath, version: 2, onCreate: createDB);
    print("Blocks Provider: Fetching Values");
    List<Map<String, dynamic>> tableValues =
        await blocksDatabase.query(Block.dbTableName);
    print("Blocks Provider: Data tables num: " + tableValues.length.toString());
    tableValues.forEach((dataMap) {
      _blocks.add(Block.fromMap(dataMap));
    });
    // DBHelper dbHelper =
    //     Provider.of<DBProvider>(context, listen: false).dbHelper;
    // List<Map<String, dynamic>> data =
    //     await dbHelper.fetchTableValues(Block.dbTableName);
    // data.forEach((dataMap) {
    //   _blocks.add(Block.fromMap(dataMap));
    // });
    notifyListeners();
  }

  void createDB(Database db, int newVersion) async {
    print("Blocks Provider: CreaeteDB: onCreate Called");
    print(Block.dbTableForm);
    db.execute(Block.dbTableForm);
  }

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

  //Saving a new Block
  bool addBlock(BuildContext context, Block newBlock) {
    print("Add block validate");
    if (!validateNewTimes(newBlock)) {
      return false;
    }
    newBlock.id = _blocks.length;
    //Pushing to Provider
    _blocks.add(newBlock);
    //Updating UI
    notifyListeners();
    print(
        "Blocks Provider: Add Block: Block added to provider, listeners notified");
    //Pushing to database Storage
    //new DB code:
    blocksDatabase.insert(Block.dbTableName, newBlock.toMap());
    // DBHelper dbHelper =
    //     Provider.of<DBProvider>(context, listen: false).dbHelper;
    // dbHelper.insertMap(
    //   newMap: newBlock.toMap(),
    //   tableName: Block.dbTableName,
    // );
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
}

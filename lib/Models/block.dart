import 'package:flutter/material.dart';
import '../tools/timeOfDay_tools.dart';

class Block {
  //information for Local Database management
  static String dbTableName = 'block_table';
  static String dbTableForm = 'CREATE TABLE $dbTableName(id INT PRIMARY KEY AUTOINCREMENT, title TEXT, strtH INT, strtM INT, endH INT, endM INT, d1 INT, d2 INT, d3 INT, d4 INT, d5 INT, d6 INT, d7 INT, group INT)';
  //Primary Data
  int id;
  String title;
  TimeOfDay start;
  TimeOfDay end;
  List<bool> days;
  //Standard Constructor
  Block({
    this.id,
    @required this.title,
    @required this.start,
    @required this.end,
    @required this.days,
  });
  //Constructor From DB
  Block.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.title = map['map'];
    this.start = TimeOfDay(hour: map['strtH'], minute: map['strtM']);
    this.end = TimeOfDay(hour: map['endH'], minute: map['endM']);
    this.days = [
      map['d1'] == 1 ? true : false,
      map['d2'] == 1 ? true : false,
      map['d3'] == 1 ? true : false,
      map['d4'] == 1 ? true : false,
      map['d5'] == 1 ? true : false,
      map['d6'] == 1 ? true : false,
      map['d7'] == 1 ? true : false,
    ];
  }

  //Convertion to DB Format
  Map<String, dynamic> toMap() {
    Map res = Map<String, dynamic>();
    if (this.id != null) {
      res['id'] = this.id;
    }
    res['title'] = this.title;
    res['startH'] = this.start.hour;
    res['startM'] = this.start.minute;
    res['endH'] = this.end.hour;
    res['endM'] = this.end.minute;
    res['d0'] = this.days[0] ? 1 : 0;
    res['d1'] = this.days[1] ? 1 : 0;
    res['d2'] = this.days[2] ? 1 : 0;
    res['d3'] = this.days[3] ? 1 : 0;
    res['d4'] = this.days[4] ? 1 : 0;
    res['d5'] = this.days[5] ? 1 : 0;
    res['d6'] = this.days[6] ? 1 : 0;
    return res;
  }

  bool isOvernight() {
    if (toDouble(end) < toDouble(start)) {
      return true;
    }
    return false;
  }
}

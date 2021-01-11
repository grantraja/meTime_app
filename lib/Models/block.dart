import 'package:flutter/material.dart';
import '../tools/timeOfDay_tools.dart';

class Block {
  int id;
  String title;
  TimeOfDay start;
  TimeOfDay end;
  List<bool> days;
  Block({
    this.id,
    @required this.title,
    @required this.start,
    @required this.end,
    @required this.days,
  });
  bool isOvernight() {
    if (toDouble(end) < toDouble(start)) {
      return true;
    }
    return false;
  }
}

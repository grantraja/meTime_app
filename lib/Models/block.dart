import 'package:flutter/material.dart';
import '../tools/timeOfDay_tools.dart';

class Block {
  String name;
  TimeOfDay start;
  TimeOfDay end;
  List<bool> days;
  Block({
    @required this.name,
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

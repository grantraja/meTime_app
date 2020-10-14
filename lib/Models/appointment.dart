import 'package:flutter/material.dart';

class Block {
  String name;
  TimeOfDay start;
  TimeOfDay end;
  DateTime day;
  Block({
    @required this.name,
    @required this.start,
    @required this.end,
    @required this.day,
  });
}

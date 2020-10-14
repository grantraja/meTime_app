import 'package:flutter/material.dart';

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
}

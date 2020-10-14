import 'package:flutter/material.dart';

int toDouble(TimeOfDay time) {
  return (time.hour * 60) + time.minute;
}

bool isConflicting(
  TimeOfDay originalStart,
  TimeOfDay originalEnd,
  TimeOfDay newStart,
  TimeOfDay newEnd,
) {
  int intOrgStr = toDouble(originalStart);
  int intOrgEnd = toDouble(originalEnd);
  int intNewStr = toDouble(newStart);
  int intNewEnd = toDouble(newEnd);
  if (intNewStr >= intOrgStr && intNewStr < intOrgEnd) {
    return true;
  }
  if (intNewEnd > intOrgStr && intNewEnd <= intOrgEnd) {
    return true;
  }
  return false;
}

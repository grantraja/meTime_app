import 'package:flutter/material.dart';
import 'Screens/daily_schedule_screen.dart';
import 'Screens/new_item_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'meTime',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DailyScheduleScreen(),
      routes: {
        DailyScheduleScreen.routeName: (ctx) => DailyScheduleScreen(),
        NewItemScreen.routeName: (ctx) => NewItemScreen(),
      },
    );
  }
}

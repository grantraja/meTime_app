import 'package:flutter/material.dart';
import 'package:meTime_app/Screens/new_item_screen.dart';
import '../Widgets/daily_body.dart';

class DailyScheduleScreen extends StatelessWidget {
  static const routeName = '/daily_schedule';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("meTime"),
      ),
      body: DailyBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(NewItemScreen.routeName);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

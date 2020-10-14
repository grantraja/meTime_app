import 'package:flutter/material.dart';
import 'Screens/daily_schedule_screen.dart';
import 'Screens/new_item_screen.dart';
import 'package:provider/provider.dart';
import 'Providers/blocks_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Blocks(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}

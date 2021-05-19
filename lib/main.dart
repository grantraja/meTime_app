import 'package:flutter/material.dart';
import 'Screens/daily_schedule_screen.dart';
import 'Screens/new_item_screen.dart';
import 'package:provider/provider.dart';

import './Providers/blocks_provider.dart';
import './Providers/db_provider.dart';


import './helpers/db_helper.dart';
import './Models/block.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("Application Build");
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => BlocksProvider(),
        ),
        Provider(
          create: (ctx) => DBProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'myTime',
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

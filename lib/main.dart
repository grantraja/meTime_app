import 'package:flutter/material.dart';
import 'Screens/daily_schedule_screen.dart';
import 'Screens/new_item_screen.dart';
import 'package:provider/provider.dart';

import './helpers/init_helper.dart';
import './Providers/blocks_provider.dart';
// import './Providers/db_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Application Build");
    return MultiProvider(
      providers: [
        // Provider(
        //   create: (ctx) => DBProvider(),
        // ),
        ChangeNotifierProvider(
          create: (ctx) => BlocksProvider(),
        ),
      ],
      child: InitHelper(
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
      ),
    );
  }
}

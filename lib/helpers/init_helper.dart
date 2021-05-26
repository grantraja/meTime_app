import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/db_provider.dart';
import '../Providers/blocks_provider.dart';

//After the architecture of the App has been create this runs to initialize the values
class InitHelper extends StatefulWidget {
  final Widget child;
  InitHelper({this.child});
  @override
  _InitHelperState createState() => _InitHelperState();
}

class _InitHelperState extends State<InitHelper> {
  int loadingState = 0;
  void loadingDelay() async {
    print("LoadingDelay: Begins");
    Provider.of<DBProvider>(context, listen: false).innitializeDBHelper();
    print("LoadingDelay: DBProvider.initialize finished");
    await Provider.of<BlocksProvider>(context, listen: false).loadData(context);
    print("LoadingDelay: BlocksProvider.loadData finished");
    await Future.delayed(const Duration(seconds: 5));
    loadingState = 1;
    setState(() {});
  }

  @override
  void initState() {
    loadingDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //This is the initialization
    //then the rest of the app is called
    if (loadingState == 0) {
      return LoadingScreen();
    } else {
      return widget.child;
    }
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "LOADING",
            style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 50,
                fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

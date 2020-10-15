import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/blocks_provider.dart';
import '../Models/block.dart';
import '../tools/timeOfDay_tools.dart';

class DailyBody extends StatelessWidget {
  static double schduleheight = 1000;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          height: schduleheight + 5,
          child: Stack(
            children: [
              //Three main layers
              //Static Background with times and dividers
              BackgroundDividers(),
              //Mutable Scheduling layer
              ScheduleItems(),
              //Statefull time marker
              TimeMarker(),
            ],
          ),
        )
      ],
    );
  }
}

class BackgroundDividers extends StatelessWidget {
  List<HourlyDivider> dividers = [];
  @override
  Widget build(BuildContext context) {
    dividers.add(HourlyDivider(
      title: "12 am",
    ));
    for (int i = 1; i < 12; i++) {
      dividers.add(HourlyDivider(
        title: i.toString() + " am",
      ));
    }
    dividers.add(HourlyDivider(
      title: "12 pm",
    ));
    for (int i = 1; i < 12; i++) {
      dividers.add(HourlyDivider(
        title: i.toString() + " pm",
      ));
    }
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        ...dividers,
      ],
    );
  }
}

class HourlyDivider extends StatelessWidget {
  final String title;
  HourlyDivider({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: DailyBody.schduleheight / 24,
      child: Column(
        children: [
          Divider(
            color: Colors.grey,
            height: 1,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                child: Row(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                      title,
                      style: TextStyle(color: Colors.grey),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: (DailyBody.schduleheight / 48) - 1,
                  ),
                  SizedBox(
                    width: 5,
                    height: 1,
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: Container(
                  color: Colors.grey,
                ),
                width: 1,
                height: (DailyBody.schduleheight / 24) - 1,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TimeMarker extends StatefulWidget {
  @override
  _TimeMarkerState createState() => _TimeMarkerState();
}

class _TimeMarkerState extends State<TimeMarker> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    double timeSpacer = (now.hour * DailyBody.schduleheight / 24) +
        (now.minute * DailyBody.schduleheight / 1440);
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 5 + timeSpacer,
            ),
            Divider(
              height: 1,
              color: Colors.red,
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: timeSpacer,
            ),
            Row(
              children: [
                SizedBox(
                  width: 45,
                ),
                ClipOval(
                  child: Container(
                    height: 10,
                    width: 10,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class ScheduleItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ScheduleBlocks(),
      ],
    );
  }
}

class ScheduleBlocks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<int> todaysBlocks =
        Provider.of<Blocks>(context).todaysBlocks(DateTime.now().weekday - 1);
    List<Column> blocksStack = [];
    todaysBlocks.forEach((id) {
      Block temp = Provider.of<Blocks>(context).findById(id);
      if (temp.isOvernight()) {
        //if the block goes past midnight
      } else {
        blocksStack.add(Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //initial spacer
            SizedBox(
              height: 5,
            ),
            //time before the block begins
            SizedBox(
              height: (temp.start.hour * DailyBody.schduleheight / 24) +
                  (temp.start.minute * DailyBody.schduleheight / 1440),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  color: Colors.green,
                  child: Center(child: Text(temp.name)),
                  width: 300,
                  height: (toDouble(temp.end) - toDouble(temp.start)) *
                      DailyBody.schduleheight /
                      1440,
                ),
                SizedBox(width: 5,)
              ],
            ),
          ],
        ));
      }
    });
    return Stack(
      children: blocksStack,
    );
  }
}

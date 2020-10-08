import 'package:flutter/material.dart';

class NewItemScreen extends StatefulWidget {
  static const routeName = '/new_item';
  int tabSelection = 0;
  List<bool> weekdays = [true, false, false, false, false, false, false];
  TimeOfDay start = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay end = TimeOfDay(hour: 0, minute: 1);
  @override
  _NewItemScreenState createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  void update() {
    setState(() {});
  }

  final _blockFormKey = GlobalKey<FormState>();
  // final _blockFormKey = GlobalKey<FormState>();
  // final _blockFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("meTime"),
      ),
      body: Container(
        child: Column(
          children: [
            //choose from 3 types of new items
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      widget.tabSelection = 0;
                      update();
                    },
                    child: Text("Schedule"),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      widget.tabSelection = 1;
                      update();
                    },
                    child: Text("Appointments"),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {
                      widget.tabSelection = 2;
                      update();
                    },
                    child: Text("Tasks"),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
              ],
            ),
            //morphing body form for the 3 types of items
            widget.tabSelection == 0
                ?
                // Container()
                //schedule block
                Form(
                    key: _blockFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 20,),
                        //Block Name
                        Text(
                          "Block Name:",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Enter Name',
                          ),
                          maxLength: 20,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                        ),
                        //Beginning and Ending times
                        Row(
                          children: [
                            Spacer(flex: 8),
                            Text("Start:"),
                            Spacer(flex: 1),
                            RaisedButton(
                              onPressed: () async {
                                widget.start = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                update();
                              },
                              child: Text(widget.start.format(context)),
                            ),
                            Spacer(flex: 6),
                            Text("End:"),
                            Spacer(flex: 1),
                            RaisedButton(
                              onPressed: () async {
                                widget.end = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                update();
                              },
                              child: Text(widget.end.format(context)),
                            ),
                            Spacer(flex: 8),
                          ],
                        ),
                        //Days of the Week
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 20),
                            Column(
                              children: [
                                Checkbox(
                                  value: widget.weekdays[0],
                                  onChanged: (value) {
                                    widget.weekdays[0] = !widget.weekdays[0];
                                    update();
                                  },
                                ),
                                Text("S")
                              ],
                            ),
                            Column(
                              children: [
                                Checkbox(
                                  value: widget.weekdays[1],
                                  onChanged: (value) {
                                    widget.weekdays[1] = !widget.weekdays[1];
                                    update();
                                  },
                                ),
                                Text("M")
                              ],
                            ),
                            Column(
                              children: [
                                Checkbox(
                                  value: widget.weekdays[2],
                                  onChanged: (value) {
                                    widget.weekdays[2] = !widget.weekdays[2];
                                    update();
                                  },
                                ),
                                Text("T")
                              ],
                            ),
                            Column(
                              children: [
                                Checkbox(
                                  value: widget.weekdays[3],
                                  onChanged: (value) {
                                    widget.weekdays[3] = !widget.weekdays[3];
                                    update();
                                  },
                                ),
                                Text("W")
                              ],
                            ),
                            Column(
                              children: [
                                Checkbox(
                                  value: widget.weekdays[4],
                                  onChanged: (value) {
                                    widget.weekdays[4] = !widget.weekdays[4];
                                    update();
                                  },
                                ),
                                Text("T")
                              ],
                            ),
                            Column(
                              children: [
                                Checkbox(
                                  value: widget.weekdays[5],
                                  onChanged: (value) {
                                    widget.weekdays[5] = !widget.weekdays[5];
                                    update();
                                  },
                                ),
                                Text("F")
                              ],
                            ),
                            Column(
                              children: [
                                Checkbox(
                                  value: widget.weekdays[6],
                                  onChanged: (value) {
                                    widget.weekdays[6] = !widget.weekdays[6];
                                    update();
                                  },
                                ),
                                Text("S")
                              ],
                            ),
                            SizedBox(width: 20),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          child: RaisedButton(
                            elevation: 5,
                            onPressed: () {},
                            child: Text("Done"),
                          ),
                        ),
                      ],
                    ),
                  )
                : widget.tabSelection == 1
                    ?
                    //appointments
                    Container()
                    :
                    //tasks
                    Container(),
          ],
        ),
      ),
    );
  }
}

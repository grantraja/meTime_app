import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/blocks_provider.dart';
import '../Models/block.dart';

//I'm lazy lol:
// ignore: must_be_immutable
class NewItemScreen extends StatefulWidget {
  static const routeName = '/new_item';
  int tabSelection = 0;
  String title;
  List<bool> weekdays = [true, false, false, false, false, false, false];
  TimeOfDay start = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay end = TimeOfDay(hour: 0, minute: 1);
  DateTime pickedDate = DateTime.now();
  @override
  _NewItemScreenState createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  void update() {
    setState(() {});
  }

  final _blockFormKey = GlobalKey<FormState>();
  final _appFormKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // final _blockFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  child: ElevatedButton(
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
                  child: ElevatedButton(
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
                  child: ElevatedButton(
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
                        SizedBox(
                          height: 20,
                        ),
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
                          onSaved: (value) {
                            widget.title = value;
                          },
                        ),
                        //Beginning and Ending times
                        Row(
                          children: [
                            Spacer(flex: 8),
                            Text("Start:"),
                            Spacer(flex: 1),
                            ElevatedButton(
                              onPressed: () async {
                                TimeOfDay buffer = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (buffer != null) {
                                  widget.start = buffer;
                                }
                                update();
                              },
                              child: Text(widget.start.format(context)),
                            ),
                            Spacer(flex: 6),
                            Text("End:"),
                            Spacer(flex: 1),
                            ElevatedButton(
                              onPressed: () async {
                                TimeOfDay buffer = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (buffer != null) {
                                  widget.end = buffer;
                                }
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
                        //Done Button
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            //elevation: 5,
                            onPressed: () {
                              print("Submit");
                              //Validates the Title
                              if (!_blockFormKey.currentState.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Name field empty')));
                                //Scaffold.of(context).showSnackBar(SnackBar(
                                    //content: Text('Name field empty')));
                                return;
                              }
                              print("Title Validated");
                              //Saves the Title
                              _blockFormKey.currentState.save();
                              //Creates temporary Block out of data
                              Block newBlock = Block(
                                title: widget.title,
                                start: widget.start,
                                end: widget.end,
                                days: widget.weekdays,
                              );
                              print("New Block generated");
                              //checks times are available
                              if (!Provider.of<BlocksProvider>(context, listen: false)
                                  .validateNewTimes(newBlock)) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('Time Unavailable')));
                                return;
                              }
                              print("Times validated");
                              //adds new block
                              Provider.of<BlocksProvider>(context, listen: false)
                                  .addBlock(newBlock);
                              print("Block Added");
                            },
                            child: Text("Done"),
                          ),
                        ),
                      ],
                    ),
                  )
                : widget.tabSelection == 1
                    ?
                    //appointments
                    Form(
                        key: _appFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Appointment Name:",
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
                            Row(
                              children: [
                                Spacer(flex: 8),
                                Text("Start:"),
                                Spacer(flex: 1),
                                ElevatedButton(
                                  onPressed: () async {
                                    TimeOfDay buffer = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (buffer != null) {
                                      widget.start = buffer;
                                    }
                                    update();
                                  },
                                  child: Text(widget.start.format(context)),
                                ),
                                Spacer(flex: 6),
                                Text("End:"),
                                Spacer(flex: 1),
                                ElevatedButton(
                                  onPressed: () async {
                                    TimeOfDay buffer = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    );
                                    if (buffer != null) {
                                      widget.end = buffer;
                                    }
                                    update();
                                  },
                                  child: Text(widget.end.format(context)),
                                ),
                                Spacer(flex: 8),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Date:"),
                                ElevatedButton(
                                  onPressed: () async {
                                    DateTime buffer = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      lastDate:
                                          DateTime(DateTime.now().year + 5),
                                      firstDate: DateTime.now(),
                                    );
                                    if (buffer != null) {
                                      widget.pickedDate = buffer;
                                    }
                                    update();
                                  },
                                  child: Text(
                                      "${widget.pickedDate.month}.${widget.pickedDate.day}.${widget.pickedDate.year}"),
                                ),
                              ],
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                //elevation: 5,
                                onPressed: () {},
                                child: Text("Done"),
                              ),
                            ),
                          ],
                        ),
                      )
                    :
                    //tasks
                    Container(),
          ],
        ),
      ),
    );
  }
}

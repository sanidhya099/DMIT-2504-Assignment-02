// ignore_for_file: avoid_print, use_key_in_widget_constructors, file_names, todo, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:robbinlaw/widgets/mysnackbar.dart';

// Do not change the structure of this files code.
// Just add code at the TODO's.

final formKey = GlobalKey<FormState>();

// We must make the variable firstName nullable.
String? firstName;
final TextEditingController textEditingController = TextEditingController();

class MyFirstPage extends StatefulWidget {
  @override
  MyFirstPageState createState() => MyFirstPageState();
}

class MyFirstPageState extends State<MyFirstPage> {
  String msg1 = '';
  String msg2 = '';
  bool enabled = false;
  int previousCount = 0;
  int timesClicked = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment2 - User Input'),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: Replace this Text Widget
              // and build the label and switch here
              // as children of the row.
           Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Enable Buttons',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Switch(
                value: enabled,
                onChanged: (bool onChangedValue) {
                  print('onChangedValue is $onChangedValue');
                  enabled = onChangedValue;
                  setState(() {
                    if (enabled) {
                      if (previousCount > 0) {
                        // Restore the count value when the switch is turned back on
                        timesClicked = previousCount;
                      } else {
                        timesClicked = 0;
                      }
                      msg1 = 'Clicked $timesClicked';
                      print('enabled is true');
                    } else {
                      // Store the count value before the switch is turned off
                      previousCount = timesClicked;
                      msg1 = 'Disabled';
                      print('enabled is false');
                    }
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //TODO: Build the two buttons here
              // as children of the row.
              // For each button use a
              // "Visibility Widget" and its child
              // will be an "ElevatedButton"
              Visibility(
                visible: enabled,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      timesClicked++;
                      msg1 = 'Clicked $timesClicked';
                      print('clicked $timesClicked');
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(msg1),
                ),
              ),
              Visibility(
                visible: enabled,
                child: const SizedBox(width: 10),
              ),
              Visibility(
                visible: enabled,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      timesClicked = 0;
                      msg1 = 'Click Me';
                    });
                  },
                  style: ElevatedButton.styleFrom(

                    shape: RoundedRectangleBorder(
                      
                      borderRadius: BorderRadius.circular(
                          10.0), // Set rounded corners here
                    ),
                  ),
                  child: Text('Reset'),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  //TODO: Build the text form field
                  // here as the first
                  // child of the column.
                  // Include as the second child
                  // of the column
                  // a submit button that will show a
                  // snackbar with the "firstName"
                  // if validation is satisfied.
                   TextFormField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                       icon: Icon(Icons.hourglass_top),
                      labelText: 'Enter Name',
                       helperText: 'min 1, max 10',
                      hintText: 'first name',
                         suffixIcon: Icon(
                    Icons.check_circle,
                  ),

                      border: OutlineInputBorder(), // Border when not focused
              focusedBorder: OutlineInputBorder( // Border when focused
              ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      } else if (value.length < 1 || value.length > 10) {
                        return 'Name must be between 1 and 10 characters';
                      }
                      return null;
                    },

                    onSaved: (value) {
                      firstName = value;
                    },
                  ),

                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        // Form is valid, show the Snackbar
                        formKey.currentState?.save();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Hey $firstName , you rocked assignment-02'),
                            duration: Duration(seconds: 6),
                            action: SnackBarAction(
                              label: 'Click Me',
                              onPressed: () {
                                print('Print button in Snackbar clicked');
                              },
                            ),
                          ),
                        );
                        textEditingController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                  )
                    ),
                    child: Text('Submit')
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
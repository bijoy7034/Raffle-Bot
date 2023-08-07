import 'dart:ui';

import 'package:aquaira/select_site_dialog.dart';
import 'package:flutter/material.dart';

class MyDialogForm extends StatefulWidget {
  @override
  _MyDialogFormState createState() => _MyDialogFormState();
}

class _MyDialogFormState extends State<MyDialogForm> with SingleTickerProviderStateMixin {


  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;
  late String name;
  late String email;
  late String address;
  late String description;
  late String phoneNumber;
  bool _isSwitched = false;


  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter:  ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('New Task Group', style: TextStyle(color: Colors.orange),),
        content: Container(
          width: 500,
          height: 80,// Adjust the width of the dialog box
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      style: const TextStyle(
                        color: Colors.white, // Set the desired text color
                      ),
                      decoration: InputDecoration(filled: true,
                          fillColor: Colors.grey[850], labelText: 'Task Group Name', focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ), border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange),
                      ), labelStyle: const TextStyle(color: Colors.white60)),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a URL';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        address = value!;
                      },
                    ),
                    const SizedBox(height: 25,),

                  ],
                )
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade800), // Set the desired button color
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Set the desired button color
            ),
            child: const Text('Save'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }
}


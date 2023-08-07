import 'dart:convert';
import 'dart:ui';

import 'package:aquaira/navigation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDialogEmail extends StatefulWidget {
  final Function() onDeleteSuccess;
  MyDialogEmail({required this.onDeleteSuccess()});
  @override
  _MyDialogFormState createState() => _MyDialogFormState();
}

class _MyDialogFormState extends State<MyDialogEmail> with SingleTickerProviderStateMixin {

  final TextEditingController _textController = TextEditingController();

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
  Future<void> createEmailGroup() async {
    final url = 'http://localhost:3000/api/emails/createGroup'; // Replace with your API endpoint

    final String groupName = _textController.text;
    final String? token = await getAccessToken();
    if (token != null) {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'GroupName': groupName,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        // Process the response if needed
        print('Email group created successfully');
        widget.onDeleteSuccess();
        Navigator.of(context).pop();
      } else {
        final responseBody = jsonDecode(response.body);
        final errorMessage = responseBody['mssg'];
        print('Failed to create email group: $errorMessage');
      }
    } else {
      print('Access token not found');
    }
  }

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
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text('New Email Group', style: TextStyle(color: Colors.orange),),
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
                        controller: _textController,
                        style: const TextStyle(
                          color: Colors.white, // Set the desired text color
                        ),
                        decoration: InputDecoration(filled: true,
                            fillColor: Colors.grey[850], labelText: 'Email Group Name', focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ), border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ), labelStyle: const TextStyle(color: Colors.white60)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a email group name';
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
            onPressed:createEmailGroup,
          ),
        ],
      ),
    );
  }
}


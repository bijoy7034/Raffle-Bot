import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:aquaira/select_site_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDialogTaskGroupEdit extends StatefulWidget {
  final String variable;
  final String idM;
  final Function() onDeleteSuccess;

  MyDialogTaskGroupEdit({required this.variable, required this.idM, required this.onDeleteSuccess});
  @override
  _MyDialogFormState createState() => _MyDialogFormState();
}

class _MyDialogFormState extends State<MyDialogTaskGroupEdit> with SingleTickerProviderStateMixin {

  late String dialogVariable;
  late TextEditingController _controller;
  late String _idMain;

  @override
  void initState() {
    super.initState();
    dialogVariable = widget.variable;
    _idMain = widget.idM;
    _controller = TextEditingController(text: dialogVariable);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;
  late String name;
  late String email;
  late String address;
  late String description;
  late String phoneNumber;
  bool _isSwitched = false;


  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');

  }
  Future<void> EditGroup(String id) async {
    final url = 'http://localhost:3000/api/emails/edit/emailGroup/$id'; // Replace with your API endpoint
    final String ListName = _controller.text;
    final String? token = await getAccessToken();
    if (token != null) {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'GroupName':ListName,
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







  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text('Edit $dialogVariable', style: TextStyle(color: Colors.orange),),
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
                        controller: _controller,
                        decoration: InputDecoration(filled: true,
                            fillColor: Colors.grey[850], labelText: dialogVariable, focusedBorder: const OutlineInputBorder(
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
              EditGroup(_idMain);
            },
          ),
        ],
      ),
    );
  }
}


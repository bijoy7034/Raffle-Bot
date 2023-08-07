import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MyDialogTaskGroupDelete extends StatefulWidget {
  final String variable;
  final String idM;
  final Function() onDeleteSuccess;

  MyDialogTaskGroupDelete({required this.variable, required this.idM, required this.onDeleteSuccess()});
  @override
  _MyDialogFormState createState() => _MyDialogFormState();
}

class _MyDialogFormState extends State<MyDialogTaskGroupDelete> with SingleTickerProviderStateMixin {


  late String _idMain;
  late String dialogVariable;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _idMain = widget.idM;
    dialogVariable = widget.variable;

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
  Future<void> deleteEmailList(String id) async {
    print(id);
    final url = 'http://localhost:3000/api/emails/delete/list/$id'; // Replace with your API endpoint

    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      // Process the response if needed
      print('Email list deleted successfully');
      widget.onDeleteSuccess();
      Navigator.of(context).pop();
    } else {
      final responseBody = jsonDecode(response.body);
      print('Failed to delete email list: $responseBody');
    }
  }


  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter:  ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text('Delete $dialogVariable', style: TextStyle(color: Colors.orange),),
        content: Container(
          width: 500,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Are you sure to delete $dialogVariable', style: TextStyle(color: Colors.white70, fontSize: 10),),
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
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Set the desired button color
            ),
            child: const Text('Delete'),
            onPressed: () {
            deleteEmailList(_idMain);
    },
          ),
        ],
      ),
    );
  }
}


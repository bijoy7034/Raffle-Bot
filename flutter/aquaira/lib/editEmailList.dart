import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class editEmailListDialog extends StatefulWidget {
  final String variable;
  final String idM;
  final Function() onDeleteSuccess;
  final List<String> emailLists;

  editEmailListDialog({required this.variable, required this.idM, required this.onDeleteSuccess(), required this.emailLists});
  @override
  _MyDialogForm2State createState() => _MyDialogForm2State();
}

class _MyDialogForm2State extends State<editEmailListDialog> with SingleTickerProviderStateMixin {


  late TextEditingController _nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late TextEditingController _controller;
  List<String> emails = [];
  int emailCount = 0;
  late String _idMain;
  late List<String> emailLists;
  void addEmail(String email) {
    setState(() {
      emails.add(email);
      emailCount = emails.length;
    });
  }

  void removeEmail(String email) {
    setState(() {
      emails.remove(email);
      emailCount = emails.length;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
    _controller.dispose();
    _nameController.dispose();
  }

  late String dialogVariable;
  bool isCheckedVisible = false;

  @override
  void initState() {
    super.initState();
    dialogVariable = widget.variable;
    _idMain = widget.idM;
    emailLists = widget.emailLists;
     _nameController = TextEditingController(text: dialogVariable);
    _controller = TextEditingController(text: emailLists.join('\n'));
  }


  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (counter > 0) {
        counter--;
      }
    });
  }
  final _formKey = GlobalKey<FormState>();
  late String input;
  bool _isSwitched = false;





  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');

  }
  Future<void> createEmailList(String id) async {
    final url = 'http://localhost:3000/api/emails/list/update/$id'; // Replace with your API endpoint
    final String ListName = _nameController.text;
    final String? token = await getAccessToken();
    print(token);
    if (token != null) {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'ListName':ListName,
          'Emails':emails
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
        title: Row(
          children: [
            Text(dialogVariable, style: const TextStyle(color: Colors.orange),)

          ],
        ),
        content: SingleChildScrollView(
          child: Container(
            width: 1100,
            height: 450,// Adjust the width of the dialog box
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 3,
                    child:Column(
                      children: [

                        Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.white, // Set the desired text color
                                ),
                                controller: _nameController,
                                decoration: InputDecoration(filled: true,
                                    fillColor: Colors.grey[850], labelText: 'Name', focusedBorder: const OutlineInputBorder(
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
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                children: [
                                  const Text('Input', style: TextStyle(color: Colors.white70),),
                                  IconButton(onPressed: (){}, icon: const Icon(Icons.help_outline,
                                    size: 18,
                                    color: Colors.white70,)),
                                  const Spacer(),
                                  Text('${emails.length} Emails', style: TextStyle(color: Colors.white70, fontSize: 12),),
                                  const SizedBox(width: 6,)
                                ],
                              ),
                              const SizedBox(height: 1,),
                              TextFormField(
                                onChanged: (text) {
                                  List<String> lines = text.trim().split('\n');
                                  setState(() {
                                    emails = List.from(lines);
                                  });
                                },
                                controller: _controller,
                                keyboardType: TextInputType.multiline,
                                style: const TextStyle(
                                  color: Colors.white, // Set the desired text color
                                ),
                                maxLines: 14,
                                decoration: InputDecoration( filled: true,
                                  fillColor: Colors.grey[850], focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.orange),
                                  ), border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.orange),
                                  ),),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an input';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  input = value!;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 33.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              const Text('Split Into Groups', style: TextStyle(color: Colors.white70 , fontSize: 13),),
                              const SizedBox(width: 6,),
                              Switch(
                                activeColor: Colors.orange,
                                activeTrackColor: Colors.orange.withOpacity(0.5),
                                inactiveThumbColor: Colors.grey,
                                inactiveTrackColor: Colors.grey.withOpacity(0.5),
                                value: _isSwitched,
                                onChanged: (bool value) {
                                  setState(() {
                                    _isSwitched = value;
                                    isCheckedVisible = true;
                                  });
                                },
                              ),


                            ],
                          ),
                          Visibility(
                            visible: _isSwitched,
                            child: Row(
                              children: [
                                Container(
                                  width: 150,
                                  child: TextField(
                                    style: const TextStyle(
                                      color: Colors.white, // Set the desired text color
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey[850], focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.orange),
                                    ), border: const OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.orange),
                                    ), labelStyle: const TextStyle(color: Colors.white60),

                                      suffixIcon: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.keyboard_arrow_up, color: Colors.orange,),
                                            onPressed: incrementCounter,
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.orange,),
                                            onPressed: decrementCounter,
                                          ),
                                        ],
                                      ),
                                    ),
                                    controller: TextEditingController(text: counter.toString()),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                const Text('Accounts Per Group', style: TextStyle(color: Colors.white70, fontSize: 12),)
                              ],
                            ),
                          ),
                          const SizedBox(height: 20,),

                          Expanded(
                            child: Visibility(
                              visible: _isSwitched,
                              child: Column(
                                children: List.generate(counter, (index) {
                                  return SizedBox(
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Text('New Email List $index' , style: const TextStyle(color: Colors.white70, fontSize: 12),),
                                        const SizedBox(width: 10,),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(3),
                                            color: Colors.grey[850],
                                          ),

                                          child: Padding(padding: const EdgeInsets.all(4),
                                            child: InkWell(
                                              onTap: (){},
                                              child: Text('1 Account', style: TextStyle(color: Colors.white70, backgroundColor: Colors.grey[850], fontSize: 10),),
                                            ),),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          )

                        ],
                      ),

                    ),
                  ),
                ),
              ],
            ),
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
              createEmailList(_idMain);
            },
          ),
        ],
      ),
    );
  }
}


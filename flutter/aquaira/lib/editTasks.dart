import 'dart:ui';

import 'package:aquaira/select_site_dialog.dart';
import 'package:flutter/material.dart';

class MyDialogTasksEdit extends StatefulWidget {
  final String variable;

  MyDialogTasksEdit({required this.variable});
  @override
  _MyDialogFormState createState() => _MyDialogFormState();
}

class _MyDialogFormState extends State<MyDialogTasksEdit> with SingleTickerProviderStateMixin {

  late String dialogVariable;

  @override
  void initState() {
    super.initState();
    dialogVariable = widget.variable;
  }
  final _formKey = GlobalKey<FormState>();
  int _currentIndex = 0;
  late String name;
  late String email;
  late String address;
  late String description;
  late String phoneNumber;
  bool _isSwitched = false;
  String? _selectedOption;

  final List<String> _emailList = [
    'Email List 1',
    'Email List 2',
    'Email List 3',
  ];
  final List<String> _proxyList = [
    'Proxy List 1',
    'Proxy List 2',
    'Proxy List 3',
  ];
  final List<String> _adressList = [
    'Address List 1',
    'Address List 2',
    'Address List 3',
  ];


  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter:  ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: AlertDialog(
        backgroundColor: Colors.grey[900],
        title:  Text(dialogVariable, style: TextStyle(color: Colors.orange),),
        content: Container(
          width: 1100,
          height: 450,// Adjust the width of the dialog box
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
                            fillColor: Colors.grey[850], labelText: 'Site URL', focusedBorder: const OutlineInputBorder(
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
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.grey[850],
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[850], labelText: 'Email List', focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ), border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ), labelStyle: const TextStyle(color: Colors.white60)
                        ),
                        value: _selectedOption,
                        items: _emailList.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option, style: TextStyle(color: Colors.white70),),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 25,),
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.grey[850],
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[850], labelText: 'Proxy List', focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ), border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ), labelStyle: const TextStyle(color: Colors.white60)
                        ),
                        value: _selectedOption,
                        items: _proxyList.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option, style: TextStyle(color: Colors.white70),),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue;
                          });
                        },
                      ),

                      const SizedBox(height: 25,),
                      DropdownButtonFormField<String>(
                        dropdownColor: Colors.grey[850],
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[850], labelText: 'Address List', focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ), border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ), labelStyle: const TextStyle(color: Colors.white60)
                        ),
                        value: _selectedOption,
                        items: _adressList.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option, style: TextStyle(color: Colors.white70),),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue;
                          });
                        },
                      ),
                      const SizedBox(height: 25,),
                      TextFormField(
                        style: const TextStyle(
                          color: Colors.white, // Set the desired text color
                        ),
                        maxLines: 3,
                        decoration: InputDecoration( filled: true,
                            fillColor: Colors.grey[850], labelText: 'Input', focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ), border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ), labelStyle: const TextStyle(color: Colors.white60)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an input';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          address = value!;
                        },
                      ),
                    ],
                  )
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          style: const TextStyle(
                            color: Colors.white, // Set the desired text color
                          ),
                          textAlignVertical: TextAlignVertical.top,
                          decoration: InputDecoration(filled: true,
                              fillColor: Colors.grey[850], labelText: 'Delay', focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ), labelStyle: const TextStyle(color: Colors.white60)),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            address = value!;
                          },
                        ),
                        const SizedBox(height: 20,),
                        const Text('Captcha Solver', style: TextStyle(color: Colors.white70),),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: _currentIndex == 0
                                      ? Colors.orange : Colors.grey[850]
                              ),
                              child: Padding(padding: const EdgeInsets.all(9),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _currentIndex = 0;
                                    });
                                  },
                                  child: Text('AYCD AI',  style: _currentIndex == 0
                                      ? const TextStyle(color: Colors.white70, backgroundColor: Colors.orange , fontSize: 10)
                                      : const TextStyle(color: Colors.white70, fontSize: 10),),
                                ),),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: _currentIndex == 1
                                      ? Colors.orange : Colors.grey[850]
                              ),
                              child: Padding(padding: const EdgeInsets.all(9),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _currentIndex = 1;
                                    });
                                  },
                                  child: Text('CapSolver',  style: _currentIndex == 1
                                      ? const TextStyle(color: Colors.white70, backgroundColor: Colors.orange , fontSize: 10)
                                      : const TextStyle(color: Colors.white70, fontSize: 10),),
                                ),),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: _currentIndex == 3
                                      ? Colors.orange : Colors.grey[850]
                              ),
                              child: Padding(padding: const EdgeInsets.all(9),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _currentIndex = 3;
                                    });
                                  },
                                  child: Text('AnyCaptcha',  style: _currentIndex == 3
                                      ? const TextStyle(color: Colors.white70, backgroundColor: Colors.orange , fontSize: 10)
                                      : const TextStyle(color: Colors.white70, fontSize: 10),),
                                ),),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: _currentIndex == 4
                                      ? Colors.orange : Colors.grey[850]
                              ),
                              child: Padding(padding: const EdgeInsets.all(9),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _currentIndex = 4;
                                    });
                                  },
                                  child: Text('2Captcha',  style: _currentIndex == 4
                                      ? const TextStyle(color: Colors.white70, backgroundColor: Colors.orange , fontSize: 10)
                                      : const TextStyle(color: Colors.white70, fontSize: 10),),
                                ),),
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: _currentIndex == 5
                                      ? Colors.orange : Colors.grey[850]
                              ),
                              child: Padding(padding: const EdgeInsets.all(9),
                                child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _currentIndex = 5;
                                    });
                                  },
                                  child: Text('CapMonster',  style: _currentIndex == 5
                                      ? const TextStyle(color: Colors.white70, backgroundColor: Colors.orange , fontSize: 10)
                                      : const TextStyle(color: Colors.white70, fontSize: 10),),
                                ),),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20,),
                        Row(
                          children: [
                            const Text('Proxy Bypass', style: TextStyle(color: Colors.white70),),
                            Switch(
                              activeColor: Colors.orange,
                              activeTrackColor: Colors.orange.withOpacity(0.5),
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey.withOpacity(0.5),
                              value: _isSwitched,
                              onChanged: (bool value) {
                                setState(() {
                                  _isSwitched = value;
                                });
                              },
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                ),
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


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:aquaira/select_site_dialog.dart';
import 'package:flutter/material.dart';

class MyDialogProxies extends StatefulWidget {
  final String variable;
  MyDialogProxies({required this.variable});
  @override
  _MyDialogForm2State createState() => _MyDialogForm2State();
}

class _MyDialogForm2State extends State<MyDialogProxies> with SingleTickerProviderStateMixin {


  late String dialogVariable;

  @override
  void initState() {
    super.initState();
    dialogVariable = widget.variable;
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




  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Row(
          children: [
            Text(dialogVariable, style: TextStyle(color: Colors.orange),)

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
                        Row(
                          children: [
                            Text('Input', style: TextStyle(color: Colors.white70),),
                            IconButton(onPressed: (){}, icon: Icon(Icons.help_outline,
                              size: 18,
                              color: Colors.white70,)),
                            Spacer(),
                            Text('12 Accounts', style: TextStyle(color: Colors.white70, fontSize: 12),),
                            SizedBox(width: 6,)
                          ],
                        ),
                        SizedBox(height: 1,),
                        Align(
                          alignment: Alignment.topLeft,
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.white, // Set the desired text color
                            ),
                            maxLines: 17,
                            decoration: InputDecoration( filled: true,
                              fillColor: Colors.grey[850], focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ), border: OutlineInputBorder(
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
                              Text('Split Into Groups', style: TextStyle(color: Colors.white70 , fontSize: 13),),
                              SizedBox(width: 6,),
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
                          ),
                          Row(
                            children: [Container(
                              width: 150,
                              child: TextField(
                                style: TextStyle(
                                  color: Colors.white, // Set the desired text color
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[850], focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ), border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ), labelStyle: TextStyle(color: Colors.white60),

                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.keyboard_arrow_up, color: Colors.orange,),
                                        onPressed: incrementCounter,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.keyboard_arrow_down, color: Colors.orange,),
                                        onPressed: decrementCounter,
                                      ),
                                    ],
                                  ),
                                ),
                                controller: TextEditingController(text: counter.toString()),
                              ),
                            ),
                              SizedBox(width: 10,),
                              Text('Accounts Per Group', style: TextStyle(color: Colors.white70, fontSize: 12),)
                            ],
                          ),
                          SizedBox(height: 20,),

                          Expanded(
                            child: Column(
                              children: List.generate(6, (index) {
                                return SizedBox(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Text('New Proxy List $index' , style: TextStyle(color: Colors.white70, fontSize: 12),),
                                      SizedBox(width: 10,),
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
            child: Text('Cancel'),
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


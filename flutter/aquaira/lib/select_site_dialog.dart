import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:aquaira/TaskPamelDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
class ImageGridDialog extends StatefulWidget {
  final String variable;

  ImageGridDialog({required this.variable});
  @override
  State<ImageGridDialog> createState() => _ImageGridDialogState();
}

class _ImageGridDialogState extends State<ImageGridDialog> {
  late String dialogVariable;
  @override
  void initState() {
    super.initState();
    dialogVariable = widget.variable;
  }
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        backgroundColor: Colors.grey[900],
        title: Container(
          width: 1200,
          height: 550,
          padding: EdgeInsets.all(3.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'New Task',
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.orange,),
                    ),
                    SizedBox(width: 20,),
                    const Text(
                      'Select Site',
                      style: TextStyle(fontSize: 12.0, color: Colors.white,),
                    ),
                  ],
                ),

                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 7.0,
                    ),
                    itemCount: 25,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Handle image selection here
                          showDialog(context: context, builder: (BuildContext context){ return MyDialogTasks(variable: dialogVariable);});
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                          InkWell(
                            onTap: (){
                              Navigator.of(context).pop();
                              showDialog(context: context, builder: (BuildContext context){ return MyDialogTasks(variable: dialogVariable);});
                            },

                            child: Container(
                              child: Image.asset('Assets/placeholder.jpg',fit: BoxFit.cover,)
                            ),
                          ),
                            Text('Site Name', style: TextStyle(color: Colors.white, fontSize: 10),)
                          ],
                        )
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // actions: <Widget>[
        //   ElevatedButton(
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade800), // Set the desired button color
        //     ),
        //     child: const Text('Cancel'),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        //   ElevatedButton(
        //     style: ButtonStyle(
        //       backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Set the desired button color
        //     ),
        //     child: const Text('Submit'),
        //     onPressed: () {
        //       showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return MyDialogTasks(variable: dialogVariable);
        //         },
        //       );
        //
        //     },
        //   ),
        // ],

      ),
    );
  }
}
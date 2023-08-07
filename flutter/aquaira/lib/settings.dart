import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController apiKeyController = TextEditingController();
  TextEditingController taskDelayController = TextEditingController();
  TextEditingController webhookController = TextEditingController();
  TextEditingController folderPathController = TextEditingController();

  bool autoSaveEnabled = true;
  int autoSaveInterval = 1; // Default interval in minutes


  @override
  void dispose() {
    apiKeyController.dispose();
    taskDelayController.dispose();
    webhookController.dispose();
    folderPathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Row(
          children: <Widget>[

            Expanded(
                child:Container(
                  padding: const EdgeInsets.only(left: 200, right: 200, top:70),
                  child: Column(
                    children: [
                      ListTile(
                        subtitle: TextFormField(
                          style: const TextStyle(
                            color: Colors.white, // Set the desired text color
                          ),
                          cursorColor: Colors.orange,
                          decoration: InputDecoration(filled: true,
                            fillColor: Colors.grey[850], labelText: 'Enter API Key', focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ), border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ), labelStyle: const TextStyle(color: Colors.white60)),

                          controller: apiKeyController,
                        ),
                      ),
                      ListTile(
                        subtitle: TextFormField(
                            style: const TextStyle(
                              color: Colors.white, // Set the desired text color
                            ),
                            cursorColor: Colors.orange,
                          controller: taskDelayController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(filled: true,
                              fillColor: Colors.grey[850], labelText: 'Enter Task Delay (in seconds)', focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ), border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ), labelStyle: const TextStyle(color: Colors.white60))
                        ),
                      ),
                      ListTile(
                        subtitle: TextFormField(
                          style: const TextStyle(
                            color: Colors.white, // Set the desired text color
                          ),
                          cursorColor: Colors.orange,
                          controller: webhookController,
                          decoration: InputDecoration(filled: true,
                              fillColor: Colors.grey[850], labelText: 'Enter Discord Webhook', focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ), border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ), labelStyle: const TextStyle(color: Colors.white60)),

                        ),
                      ),
                      ListTile(

                        subtitle: TextFormField(
                          style: const TextStyle(
                            color: Colors.white, // Set the desired text color
                          ),
                          cursorColor: Colors.orange,
                          controller: folderPathController,
                          decoration: InputDecoration(filled: true,
                              fillColor: Colors.grey[850], labelText: 'Enter Folder Path', focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ), border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.orange),
                              ), labelStyle: const TextStyle(color: Colors.white60)),
                        ),
                      ),
                      ListTile(
                        contentPadding: const EdgeInsets.only(right: 900),
                        subtitle: CheckboxListTile(
                          checkColor: Colors.white70,
                          activeColor: Colors.orange,
                          value: autoSaveEnabled,
                          onChanged: (value) {
                            setState(() {
                              autoSaveEnabled = value!;
                            });
                          },
                          title: const Text('Enable Auto Save',style: TextStyle(color: Colors.white70),),
                        ),
                      ),
                      if (autoSaveEnabled) ...[
                        ListTile(
                          subtitle: TextFormField(
                            style: const TextStyle(
                              color: Colors.white, // Set the desired text color
                            ),
                            cursorColor: Colors.orange,
                            initialValue: autoSaveInterval.toString(),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                autoSaveInterval = int.tryParse(value) ?? 1;
                              });
                            },
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[850], labelText: 'Enter Auto Save Interval (in minutes)', focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ), border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.orange),
                                ), labelStyle: const TextStyle(color: Colors.white60)),
                          ),
                        ),

                      ],
                      const SizedBox(height: 20,),
                      Row(
                        children: [
                          const SizedBox(width: 20,),
                          Container(
                            width: 200,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange, // Set the background color to orange
                              ),
                              onPressed: () {
                                // Open folder button action
                              },
                              child: const Text('User Logs'),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Container(
                            width: 200,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange, // Set the background color to orange
                              ),
                              onPressed: () {
                                // Export configuration button action
                              },
                              child: const Text('Export Configuration'),
                            ),
                          ),
                          const SizedBox(width: 20,),
                          Container(
                            width: 200,
                            height: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.orange, // Set the background color to orange
                              ),
                              onPressed: () {
                                // Import configuration button action
                              },
                              child: const Text('Import Configuration'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:aquaira/Authenticator/login.dart';
import 'package:aquaira/Proxies.dart';
import 'package:aquaira/Verifiers.dart';
import 'package:aquaira/settings.dart';
import 'package:flutter/material.dart';
import 'package:aquaira/profiles.dart';
import 'package:aquaira/tasks.dart';

class DesktopApp extends StatefulWidget {
  @override
  _DesktopAppState createState() => _DesktopAppState();
}

class _DesktopAppState extends State<DesktopApp> with SingleTickerProviderStateMixin {
  List<String> notifications = [
    "Notification 1",
    "Notification 2 ",
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sweepsy',
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Colors.orange), // Change the color here
        ),
      ),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            elevation: 0,
            actions: [
              Container(
                child: Row(
                  children: [
                    Text('V.1.0.0', style: TextStyle(color: Colors.orange, fontSize: 13),),
                    IconButton(
                      alignment: Alignment.center,
                      icon:  Image.asset(
                        'Assets/account.png',
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        // Handle account icon press
                      },
                    ),
                    const SizedBox(width: 3,),
                    IconButton(
                      alignment: Alignment.center,
                      icon:  Image.asset(
                        'Assets/notofication.png',
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Align(
                              alignment: Alignment.topRight,
                              child: FractionallySizedBox(
                                widthFactor: 0.5,
                                child: Container(
                                  width: 400,
                                  height: 400,
                                  child: BackdropFilter(
                                    filter:  ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                    child: AlertDialog(
                                      backgroundColor: Colors.grey[900],
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.notifications_active_outlined, color: Colors.orange,),
                                              const Text(" Notifications", style: TextStyle(color: Colors.orange)),
                                              const Spacer(),
                                              ElevatedButton(
                                                onPressed: () {
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                        (Set<MaterialState> states) {
                                                      if (states.contains(MaterialState.pressed)) {
                                                        return Colors.orange; // Color when button is pressed
                                                      } else if (states.contains(MaterialState.focused)) {
                                                        return Colors.orangeAccent; // Color when button is focused
                                                      }
                                                      // Default color
                                                      return Colors.grey.shade800;
                                                    },
                                                  ),
                                                ),
                                                child: const Text('View All'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      content: Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: ListView.builder(
                                          itemCount: notifications.length,
                                          itemBuilder: (context, index) {
                                            return SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10.0),
                                                      color: Colors.grey[850],
                                                    ),
                                                    child: ListTile(
                                                      tileColor: Colors.grey[900],
                                                      trailing: IconButton(icon: const Icon(Icons.more_vert, color: Colors.white70,), onPressed: () {  },),
                                                      title: Text(notifications[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                                      subtitle: const Text('Details about the notification',style :TextStyle(color: Colors.white54)),
                                                      onTap: () {
                                                        // Handle notification item tap
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(height: 10,),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text("Close", style: TextStyle(color: Colors.white70),),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },

                    ),
                    IconButton(
                      alignment: Alignment.center,
                      icon:  Image.asset(
                        'Assets/logout.png',
                        width: 24,
                        height: 24,
                      ),
                      onPressed: () {
                        {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()));
                        }
                      },
                    ),
                    const SizedBox(width: 30,),

                  ],
                ), )

            ],
            backgroundColor: Colors.grey[850],
            title: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Image.asset(
                    'Assets/Sweepsy Logo 2-notext.png',
                    width: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: Text('Sweepsy', style: TextStyle(color: Colors.orange, fontSize: 25),),
                  )
                ],
              ),
            ),



            flexibleSpace: Padding(
              padding: const EdgeInsets.only(left: 500, right:500, top:20),
              child: TabBar(
                  labelColor: Colors.orange, // Change the selected tab text color
                  unselectedLabelColor: Colors.white,
                  indicator: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(6) , topRight: Radius.circular(6)),
                    color: Colors.grey[900], // Set the color of the selected tab and the indicator
                  ),
                  tabs: const [
                    Tab(text: 'Tasks',),
                    Tab(text: 'Profiles',),
                    Tab(text: 'Proxies',),
                    Tab(text: 'Verifiers',),
                    Tab(text: 'Settings',)
                  ]
              ),
            ),


          ),
          body:  TabBarView(
              children: [
                Tasks(),
                Profiles(),
                Proxies(),
                Verifiers(),
                SettingsPage(),

              ]
          ),
        ),
      ),
    );
  }
}
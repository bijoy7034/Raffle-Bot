import 'dart:ui';

import 'package:aquaira/Authenticator/login.dart';
import 'package:aquaira/navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:desktop_window/desktop_window.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  DesktopWindow.setMinWindowSize(const Size(400, 600));
  runApp(MaterialApp( debugShowCheckedModeBanner: false, home: MyApp()));
}
final navigatorKey = GlobalKey<NavigatorState>();
Future initialization(BuildContext? context)async{
  await Future.delayed(const Duration(seconds: 3));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Test",
      home: Login(),
    );
  }
}




import 'package:design_app_notes/auth/login.dart';
import 'package:design_app_notes/auth/signup.dart';
import 'package:design_app_notes/card/addnotes.dart';
import 'package:design_app_notes/home/homepage.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: ThemeData(
          primaryColor: Colors.blue,
          textTheme: TextTheme(
              headline6: TextStyle(fontSize: 20, color: Colors.white))),
      routes: {
        'login': (context) => Login(),
        'signup': (context) => SignUp(),
        'homepage':(context) => HomePage(),
        'addnotes':(context) => AddNotes(),
      },
    );
  }
}

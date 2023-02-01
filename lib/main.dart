import 'package:design_app_notes/auth/login.dart';
import 'package:design_app_notes/auth/signup.dart';
import 'package:design_app_notes/card/addnotes.dart';
import 'package:design_app_notes/home/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
bool islogin=false;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user=FirebaseAuth.instance.currentUser;
  if(user == null){
    islogin = false;
  }
  else{
    islogin=true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: islogin == false ?Login() : HomePage(),
      title: "Notes",
      theme: ThemeData(
          primaryColor: Colors.blue,
          textTheme: const TextTheme(
            headline6: TextStyle(fontSize: 20, color: Colors.white),
            headline5: TextStyle(fontSize: 30, color: Colors.blue),
            bodyText2: TextStyle(fontSize: 20, color: Colors.black),)),
      routes: {
        'login': (context) => Login(),
        'signup': (context) => SignUp(),
        'homepage':(context) => HomePage(),
        'addnotes':(context) => AddNotes(),
      },
    );
  }
}

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:design_app_notes/components/lodingalertdialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  var myusername, myemail, mypassword;

  singUp() async {
    var formdate = formstate.currentState;
    if (formdate!.validate()) {
      formdate.save();

      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Password is to weak"))
            ..show();
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("The account already exists for that email"))
            ..show();
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset('assets/images/logo.PNG')),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (val) {
                        myusername = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "user name can't to be larger than 100 letter";
                        } else if (val.length < 2) {
                          return "user name can't to be less than 2 letter";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Enter user name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        myemail = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "email can't to be larger than 100 letter";
                        } else if (val.length < 2) {
                          return "email can't to be less than 2 letter";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.lock_rounded),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        mypassword = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Password can't to be larger than 100 letter";
                        } else if (val.length < 4) {
                          return "password can't to be less than 4 letter";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock_rounded),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: ElevatedButton(
                        child: Text(
                          'Signup',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        onPressed: () async {
                          UserCredential response = await singUp();
                          print("========================");
                          if (response != null) {
                            await FirebaseFirestore.instance.collection("users").add({

                              "username": myusername ,
                              "email" : myemail

                            });

                            Navigator.of(context)
                                .pushReplacementNamed("homepage");
                          } else
                            print("Sing Up Faild");
                          print("========================");
                        },
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Do have any account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("login");
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}

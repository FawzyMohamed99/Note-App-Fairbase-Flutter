import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:design_app_notes/components/lodingalertdialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}


class _LoginState extends State<Login> {

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  var  myemail, mypassword;

  singIn()async{
    var formdate = formstate.currentState;
    if (formdate!.validate())
    {
      formdate.save();
      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("No user found for that email"))
            ..show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Wrong password provided for that user"))
            ..show();
        }}


    }else
      {
        print('not validate');
      }
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
                      labelText: "Enter Email",
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
                      'Login',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onPressed: () async
                    {
                     var user= await singIn();
                     if(user !=null){
                       Navigator.of(context).pushReplacementNamed('homepage');
                     }

                    },
                  ),
                ),
                SizedBox(
                  height: 18,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have any account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed("signup");
                      },
                      child: Text(
                        'SingUp',
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

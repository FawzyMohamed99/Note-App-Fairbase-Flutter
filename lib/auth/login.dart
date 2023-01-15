import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                child: Column(
              children: [
                TextFormField(
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
                    onPressed: ()
                    {
                      Navigator.of(context).pushReplacementNamed('homepage');
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

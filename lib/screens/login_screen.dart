import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/main.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

import 'package:todoapp/validator.dart';
import 'package:flutter/widgets.dart';

import '../firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  User? user;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late User _currentUser;
  final _formKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    late User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            user: user,
          ),
        ),
      );
    }

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData(),
      child: MaterialApp(
        home: GestureDetector(
          onTap: () {
            _focusEmail.unfocus();
            _focusPassword.unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text('Todo App'),
              centerTitle: true,
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                future: _initializeFirebase(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24.0, top: 30, bottom: 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 30.0, top: 12),
                            child: Text('Sign In',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 40)),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller: _emailTextController,
                                  focusNode: _focusEmail,
                                  validator: (value) => Validator.validateEmail(
                                    email: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                TextFormField(
                                  controller: _passwordTextController,
                                  focusNode: _focusPassword,
                                  obscureText: true,
                                  validator: (value) =>
                                      Validator.validatePassword(
                                    password: value,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    errorBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24.0),
                                _isProcessing
                                    ? const CircularProgressIndicator()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                _focusEmail.unfocus();
                                                _focusPassword.unfocus();

                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    _isProcessing = true;
                                                  });

                                                  User? user =
                                                      await FirebaseAuthHelper
                                                          .signInUsingEmailPassword(
                                                    email: _emailTextController
                                                        .text,
                                                    password:
                                                        _passwordTextController
                                                            .text,
                                                    name: _nameTextController
                                                        .text,
                                                  );

                                                  setState(() {
                                                    _isProcessing = false;
                                                  });

                                                  if (user != null) {
                                                    // ignore: use_build_context_synchronously
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomeScreen(
                                                                user: user),
                                                      ),
                                                    );
                                                  }
                                                }
                                              },
                                              child: Text(
                                                'Sign In',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.blue),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                              height: 15, width: 24.0),
                                        ],
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text("If don't have an account?"),
                                      InkWell(
                                        child: const Text(
                                          'SignUp',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const SignUpScreen()));
                                        },
                                      )
                                    ]),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

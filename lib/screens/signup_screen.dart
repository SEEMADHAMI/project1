import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/screens/login_screen.dart';

import 'package:todoapp/validator.dart';

import '../firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Create Account'),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0, left: 24, right: 24),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _registerFormKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _nameTextController,
                          focusNode: _focusName,
                          validator: (value) => Validator.validateName(
                            name: value,
                          ),
                          decoration: InputDecoration(
                            hintText: "Name",
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
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
                        const SizedBox(height: 12.0),
                        TextFormField(
                          controller: _passwordTextController,
                          focusNode: _focusPassword,
                          obscureText: true,
                          validator: (value) => Validator.validatePassword(
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
                        const SizedBox(height: 32.0),
                        _isProcessing
                            ? const CircularProgressIndicator()
                            : Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          _isProcessing = true;
                                        });

                                        if (_registerFormKey.currentState!
                                            .validate()) {
                                          User? user = await FirebaseAuthHelper
                                              .registerUsingEmailPassword(
                                            name: _nameTextController.text,
                                            email: _emailTextController.text,
                                            password:
                                                _passwordTextController.text,
                                          );

                                          setState(() {
                                            _isProcessing = false;
                                          });

                                          if (user != null) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreen(user: user),
                                              ),
                                              ModalRoute.withName('/'),
                                            );
                                          }
                                        } else {
                                          setState(() {
                                            _isProcessing = false;
                                          });
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                      ),
                                      child: const Text(
                                        'Sign up',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("I have already an account./"),
                              InkWell(
                                child: const Text(
                                  'Login',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                },
                              )
                            ]),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

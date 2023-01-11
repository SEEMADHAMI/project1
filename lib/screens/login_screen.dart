import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/reusablecode/reusable.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/screens/signup_screen.dart';

import '../firebase_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Login"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(hintText: 'Email'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Email";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration:
                              const InputDecoration(hintText: 'Password'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          }),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              RoundButton(
                title: 'Login',
                loading: false,
                onTap: (() {
                  if (_formKey.currentState!.validate()) {}
                  firebase
                      .signInUsingEmailPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((value) {
                    final text = "Welcome to homescreen";
                    final snackBar = SnackBar(content: Text(text));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  }).catchError((e) {
                    // TODO ADD SNACKBAR HERE TO SHOW THE ERRORS
                    final text = "Unable to login";
                    final snackBar = SnackBar(content: Text(text));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: const Text('SignUp'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

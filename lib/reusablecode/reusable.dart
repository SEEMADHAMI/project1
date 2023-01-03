import 'package:flutter/material.dart';
import 'package:todoapp/validator.dart';


final _emailTextController = TextEditingController();
final _passwordTextController = TextEditingController();

final _focusEmail = FocusNode();
final _focusPassword = FocusNode();

Widget EmailTextForm() {
  return TextFormField(
    controller: _emailTextController,
    focusNode: _focusEmail,
    validator: (value) => Validator.validateEmail(
      email: value,
    ),
    decoration: InputDecoration(
      hintText: "Email",
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
    ),
  );
}

Widget PasswordTextForm() {
  return TextFormField(
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
        borderSide: BorderSide(
          color: Colors.red,
        ),
      ),
    ),
  );
}



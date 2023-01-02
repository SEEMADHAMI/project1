import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_svg/flutter_svg.dart';

Widget colorButton(String text) {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  return InkWell(
    onTap: () async {
      try {
        firebase_auth.UserCredential userCredential =
            await firebaseAuth.signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        print(userCredential.user?.email);
      } catch (e) {
        print(e);
      }
    },
    child: Container(
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c),
          ])),
      child: Center(
        child: Text(
          'Sign In',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    ),
  );
}

class _passwordController {
  static var text;
}

class _emailController {
  static var text;
}

Widget buttonItem(String imagePath, String butonName, double size) {
  return Container(
    child: Card(
      color: Colors.black,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            imagePath,
            height: size,
            width: size,
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            butonName,
            style: TextStyle(color: Colors.white, fontSize: 17),
          )
        ],
      ),
    ),
  );
}

Widget textItem(
    String labelText, TextEditingController controller, bool obscureText) {
  return Container(
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(fontSize: 18, color: Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 18, color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            width: 1.5,
            color: Colors.amber,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
    ),
  );
}

Widget color2Button(String text) {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  return InkWell(
    onTap: () async {
      try {
        firebase_auth.UserCredential userCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        print(userCredential.user?.email);
      } catch (e) {
        print(e);
      }
      
    },
    child: Container(
      height: 55,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c),
          ])),
      child: Center(
        child: Text(
          'Sign Up',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    ),
  );
}

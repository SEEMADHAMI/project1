// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:todoapp/screens/home_screen.dart';

// import 'screens/login_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);
//   late User _currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TODO App',
//       debugShowCheckedModeBanner: true,
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primarySwatch: Colors.blue,
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             textStyle: const TextStyle(
//               fontSize: 24.0,
//             ),
//             padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
//           ),
//         ),
//         textTheme: TextTheme(
//           headline1: TextStyle(
//             fontSize: 46.0,
//             color: Colors.blue.shade700,
//             fontWeight: FontWeight.w500,
//           ),
//           bodyText1: const TextStyle(fontSize: 18.0),
//         ),
//       ),
//       home: LoginScreen(),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/screens/login_screen.dart';
import 'package:todoapp/screens/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

// Firebase Auth Instance
FirebaseAuth auth = FirebaseAuth.instance;

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: App()),
    );
  }
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  late User _currentUser;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          final user =
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
            if (user == null) {
              print('User signed out');
            } else {
              print('User signed in');
            }
          });

          // Check for errors
          if (snapshot.hasError) {
            return Container(
              child: Text("Unable to log in"),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (user != null) {
              return LoginScreen();
            } else {
              return HomeScreen(
                user: _currentUser,
              );
            }
          }

          return SignUpScreen();
        },
      ),
    );
  }
}

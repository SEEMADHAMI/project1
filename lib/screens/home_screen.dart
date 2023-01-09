import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todoapp/screens/login_screen.dart';
import 'package:todoapp/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  late final User user;

  HomeScreen({super.key, required this.user});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User _currentUser;

  @override
  void initState() {
    _currentUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('HomeScreen'),
          centerTitle: true,
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      user: _currentUser,
                    ),
                  ),
                );
              },
              child: const Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__480.png'),
                ),
              ),
            ),
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(user: _currentUser)));
            final logout = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Are you sure?'),
                  content: const Text('Logout from this App'),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    TextButton(
                      onPressed: () {
                        Logout();
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      child: const Text('No'),
                    ),
                  ],
                );
              },
            );
            return logout!;
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'NAME: ${_currentUser.displayName}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 16.0),
                Text(
                  'EMAIL: ${_currentUser.email}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();

                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: const Text('Sign out'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ));
  }

  Future<dynamic> Logout() async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}

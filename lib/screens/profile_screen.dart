import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/screens/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  User user;

  ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        centerTitle: true,
        title: const Text("Profile Screen"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomeScreen()));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                    "https://i.pinimg.com/736x/6b/e1/aa/6be1aa1902ce295f70e6a1d91587bd51.jpg"),
                radius: 70,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Name: ${_currentUser.displayName}',
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Email: ${_currentUser.email}',
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) => EditP(
                  //       user: _currentUser,
                  //     ),
                  //   ),
                  // );
                },
                child: Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 14),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  const ListTile(
                    title: Text("Your Favourite"),
                    leading: Icon(Icons.favorite),
                  ),
                  const ListTile(
                    title: Text("Payment"),
                    leading: Icon(Icons.payment),
                  ),
                  const ListTile(
                    title: Text("Settings"),
                    leading: Icon(Icons.settings),
                  ),
                  ListTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: const Text('Logout'),
                    ),
                    leading: const Icon(Icons.logout),
                  )
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

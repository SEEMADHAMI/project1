import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:todoapp/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile Screen"),
      ),
      body: ListView(children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                    "https://i.pinimg.com/736x/6b/e1/aa/6be1aa1902ce295f70e6a1d91587bd51.jpg"),
                radius: 70,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Nicky Jannos",
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              Text("nickjohn@gmail.com"),
              SizedBox(
                height: 15,
              ),
              ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: Text("Your Favourite"),
                    leading: Icon(Icons.favorite),
                  ),
                  ListTile(
                    title: Text("Payment"),
                    leading: Icon(Icons.payment),
                  ),
                  ListTile(
                    title: Text("Settings"),
                    leading: Icon(Icons.settings),
                  ),
                  ListTile(
                    title: InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();

                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text('Logout'),
                    ),
                    leading: Icon(Icons.logout),
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

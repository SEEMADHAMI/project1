import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/screens/home_screen.dart';
import 'package:todoapp/screens/profile_screen.dart';

class EditProfile extends StatefulWidget {
  late final User user;

  EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool isLoading = false;
  late User _currentUser;

  @override
  void initState() {
    super.initState();
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool showPassword = false;
  late User? user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();

              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    user: _currentUser,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 35, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://images.unsplash.com/photo-1587584867790-cf443d163e87?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8M3w5NDUyNDk0fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=900&q=60")),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 2,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            color: const Color.fromARGB(255, 25, 181, 150),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              buildTextMethod("Name", " ${_currentUser.displayName}", false),
              const SizedBox(
                height: 10,
              ),
              buildTextMethod("Email", "${_currentUser.email}", false),
              const SizedBox(
                height: 10,
              ),
              buildTextMethod("Password", "", true),
              const SizedBox(
                height: 15,
              ),
              button()
            ],
          ),
        ),
      ),
    );
  }

  Padding button() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          OutlinedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      user: _currentUser,
                    ),
                  ),
                );
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                    fontSize: 14, letterSpacing: 2.2, color: Colors.black),
              )),
          OutlinedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    // If the button is pressed, return green, otherwise blue
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.green;
                    }
                    return Colors.blue;
                  }),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ))),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      user: _currentUser,
                    ),
                  ),
                );
              },
              child: const Text(
                "Save",
                style: TextStyle(
                    fontSize: 14, letterSpacing: 2.2, color: Colors.black),
              )),
        ],
      ),
    );
  }

  Padding buildTextMethod(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: const Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> getUserStateListener() {
    return auth.authStateChanges();
  }

  Future<User?> registerUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;

      await user?.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  Future<UserCredential> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    return auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

final FirebaseHelper firebase = FirebaseHelper();

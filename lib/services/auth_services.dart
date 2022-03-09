import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  Future signIn(email, passwd) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: passwd);
    } catch (e) {
      print(e);
    }
  }

  Future signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }
}

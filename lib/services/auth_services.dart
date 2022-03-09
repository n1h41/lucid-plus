import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  Future signIn(email, passwd) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: passwd);
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

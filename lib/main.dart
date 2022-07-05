// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_const

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lucid_plus/constants.dart';
import 'package:lucid_plus/screens/home_screen.dart';
import 'package:lucid_plus/screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: primaryColor,
        // hello testing
        scaffoldBackgroundColor: const Color(0xfffbfbfb),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          elevation: 0,
          color: scaffoldBackgroundColor,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      home: StreamBuilder<User?>(
        //nihal ivde vanneenu
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          return const SignInScreen();
        }),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

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
        /* primarySwatch: Colors.blue, */
        fontFamily: 'Poppins',
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Color(0xfffbfbfb),
        appBarTheme: AppBarTheme(
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
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          }
          return SignInScreen();
        }),
      ),
    );
  }
}

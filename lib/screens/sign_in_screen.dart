// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:lucid_plus/constants.dart';
import 'package:lucid_plus/services/auth_services.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool showLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: size.height * 0.16),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: .5),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Container(
                      padding: EdgeInsets.only(
                        top: size.height * 0.05,
                        left: size.width * 0.08,
                        right: size.width * 0.08,
                      ),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login to your account',
                              style: TextStyle(
                                fontSize: size.height * 0.02,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.045,
                            ),
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                RegExp regExp = RegExp(r"(\w+@\w+\.\w{2,5})");
                                if (value!.length <= 2) {
                                  return 'Invalid email';
                                } else if (regExp.hasMatch(value) != true) {
                                  return 'Invalid email';
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle:
                                    TextStyle(fontSize: size.height * 0.019),
                                prefixIcon: Padding(
                                  padding: EdgeInsets.all(size.height * 0.01),
                                  child: Icon(Icons.email),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.04,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: passwdController,
                              validator: (value) {
                                if (value!.length <= 7) {
                                  return 'Invalid password';
                                }
                              },
                              decoration: InputDecoration(
                                labelStyle:
                                    TextStyle(fontSize: size.height * 0.019),
                                labelText: 'Password',
                                prefixIcon: Padding(
                                  padding:  EdgeInsets.all(size.height * 0.01),
                                  child: Icon(Icons.password),
                                ),
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.08,
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  showLoading = true;
                                });
                                if (_formKey.currentState!.validate() == true) {
                                  AuthServices().signIn(emailController.text.trim(),
                                      passwdController.text.trim());
                                }
                                Future.delayed(
                                    const Duration(milliseconds: 8000), () {
                                  setState(() {
                                    showLoading = false;
                                  });
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: size.width * 0.03),
                                height: size.height * 0.07,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(0, 2),
                                      spreadRadius: -1,
                                      blurRadius: 3,
                                    )
                                  ],
                                  color: btnCndVColor,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: showLoading
                                      ? [
                                          const CircularProgressIndicator(
                                            backgroundColor: Colors.white,
                                            color: btnCndVColor,
                                            strokeWidth: 1.5,
                                          )
                                        ]
                                      : [
                                          const Spacer(),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: size.width * 0.06),
                                            child: const Center(
                                              child: Text(
                                                'CONTINUE',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

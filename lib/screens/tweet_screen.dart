// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lucid_plus/services/firestore_services.dart';

class TweetScreen extends StatefulWidget {
  const TweetScreen({Key? key, this.tweetId, this.tweet}) : super(key: key);
  final String? tweetId;
  final String? tweet;

  @override
  State<TweetScreen> createState() => _TweetScreenState();
}

class _TweetScreenState extends State<TweetScreen> {
  @override
  void initState() {
    super.initState();
    checkIsEditing();
  }

  void checkIsEditing() {
    if (widget.tweetId != null && widget.tweet != null) {
      setState(() {
        isEditing = true;
        tweetController.text = widget.tweet!;
      });
    }
  }

  bool isEditing = false;

  TextEditingController tweetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back)),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      'Tweet',
                      style: TextStyle(
                        fontSize: size.height * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                TextField(
                  controller: tweetController,
                  maxLines: 5,
                  maxLength: 280,
                  decoration: InputDecoration(
                    hintText: 'What\'s happening?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: size.height * 0.07,
            child: ElevatedButton(
              onPressed: () {
                if (isEditing) {
                  FirestoreServices().updateTweet(
                      tweetController, widget, context);
                } else {
                  FirestoreServices().saveTweet(tweetController, context);
                }
              },
              child: Text(
                'Tweet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.height * 0.03,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

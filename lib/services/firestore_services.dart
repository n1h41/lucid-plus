import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreServices {
  Future saveTweet(tweetController,context) async {
    try {
      if (tweetController.text.isNotEmpty) {
        final tweetDoc = FirebaseFirestore.instance.collection('tweets').doc();
        final data = {
          'tweet': tweetController.text.trim(),
          'createdAt': DateTime.now().millisecondsSinceEpoch,
        };
        tweetDoc.set(data);
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  Future updateTweet(tweetController, widget, context) async {
    try {
      if (tweetController.text.isNotEmpty) {
        final tweetDoc = FirebaseFirestore.instance
            .collection('tweets')
            .doc(widget.tweetId!);
        final data = {
          'tweet': tweetController.text.trim(),
        };
        tweetDoc.update(data);
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }
}
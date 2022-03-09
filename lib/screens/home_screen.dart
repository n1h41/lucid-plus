// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lucid_plus/models/tweet_model.dart';
import 'package:lucid_plus/screens/tweet_screen.dart';
import 'package:lucid_plus/services/auth_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static final CollectionReference _tweets =
      FirebaseFirestore.instance.collection('tweets');

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return TweetScreen();
              }),
            );
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          padding: EdgeInsets.all(size.height * 0.01),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.002,
                  ),
                  Text(
                    'Your Tweets',
                    style: TextStyle(
                      fontSize: size.height * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                      onPressed: AuthServices().signOut,
                      icon: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ))
                ],
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(size.height * 0.01),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _tweets.snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final tweets = snapshot.data!.docs
                          .map((e) => TweetModel.fromJson(
                              e.data() as Map<String, dynamic>, e.id))
                          .toList();
                      tweets.sort((m1, m2) {
                        return m2.createdAt!
                            .toInt()
                            .compareTo(m1.createdAt!.toInt());
                      });
                      return ListView.builder(
                        itemCount: tweets.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: size.height * 0.005),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    tweets[index].tweet!,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: size.height * 0.025,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text('Edit'),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return TweetScreen(
                                                tweetId: tweets[index].id,
                                                tweet: tweets[index].tweet);
                                          }),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: size.width * 0.02,
                                    ),
                                    RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.red,
                                      onPressed: () {
                                        /* print(tweets[index].id); */
                                        FirebaseFirestore.instance
                                            .collection('tweets')
                                            .doc(tweets[index].id)
                                            .delete();
                                      },
                                    ),
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          );
                        },
                      );
                    },
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

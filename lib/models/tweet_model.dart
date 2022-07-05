import 'dart:convert';

TweetModel tweetModelFromJson(String str, String id) =>
    TweetModel.fromJson(json.decode(str), id);

String tweetModelToJson(TweetModel data) => json.encode(data.toJson());

class TweetModel {
  TweetModel({
    this.tweet,
    required this.createdAt,
    this.id,
  });

  String? tweet;
  final int createdAt;
  String? id;

  factory TweetModel.fromJson(Map<String, dynamic> json, String id) => TweetModel(
        tweet: json["tweet"],
        createdAt: json["createdAt"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "tweet": tweet,
        "createdAt": createdAt,
        "id": id,
      }..removeWhere((key, value) => value == null);
}

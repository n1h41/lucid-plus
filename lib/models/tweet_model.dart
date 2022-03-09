import 'dart:convert';

TweetModel tweetModelFromJson(String str, String id) =>
    TweetModel.fromJson(json.decode(str), id);

String tweetModelToJson(TweetModel data) => json.encode(data.toJson());

class TweetModel {
  TweetModel({
    this.tweet,
    this.createdAt,
    this.id,
  });

  String? tweet;
  int? createdAt;
  String? id;

  factory TweetModel.fromJson(Map<String, dynamic> json, String id) => TweetModel(
        tweet: json["tweet"] == null ? null : json["tweet"],
        createdAt: json["createdAt"] == null ? null : json["createdAt"],
        id: id == null ? null : id,
      );

  Map<String, dynamic> toJson() => {
        "tweet": tweet == null ? null : tweet,
        "createdAt": createdAt == null ? null : createdAt,
        "id": id == null ? null : id,
      };
}

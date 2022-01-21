import 'package:flutter/cupertino.dart';

class PostModel {
  String name;
  String dateTime;
  String post;
  String postImage;
  String uId;
  String profileImage;


  PostModel({
    this.name,
    this.dateTime,
    this.post,
    this.postImage,
    this.profileImage,
    this.uId,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateTime = json['dateTime'];
    post = json['post'];
    postImage = json['postImage'];
    profileImage = json['profileImage'];
    uId = json['uId'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'dateTime': dateTime,
      'post': post,
      'postImage': postImage,
      'profileImage': profileImage,
    };
  }
}

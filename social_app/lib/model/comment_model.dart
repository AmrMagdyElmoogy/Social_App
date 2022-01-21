import 'package:flutter/material.dart';

class CommentModel {
  String name;
  String uid;
  String profileImage;
  String commentText;
  

  CommentModel({
    this.name,
    this.uid,
    this.profileImage,
    this.commentText,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uid = json['uid'];
    profileImage = json['profileImage'];
    commentText = json['commentText'];
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'profileImage': profileImage,
      'commentText': commentText,
    };
  }
}

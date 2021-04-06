import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:picturn/Models/profile.dart';

class Post {
  final Profile profile;
  final DateTime date;

  String imageID;
  bool isLiked;
  int likesCount;

  Set profileLiked = {};
  DatabaseReference id;
  File imageFile;

  Post(this.profile, this.date, this.likesCount,
      {this.isLiked = false});

  void setId(DatabaseReference id) {
    this.id = id;
    imageID = id.key;
  }

  void setImageFile(File imageFile) {
    this.imageFile = imageFile;
  }

  Map<String, dynamic> toJson() {
    return {
      'imageID': this.id.key,
      'nickName': this.profile.nickName,
      'avatarImagePath': this.profile.avatarImagePath,
      'date': formatDate(this.date, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
      'profileLiked': this.profileLiked.toList(),
    };
  }


  static Post createPostFromJson(record) {
    Map<String, dynamic> attributes = {
      'imageID': '',
      'nickName': '',
      'avatarImagePath': '',
      'date': '',
      'profileLiked': [],
    };

    print(record.toString());

    record.forEach((key, value) => {attributes[key] = value});

    print(attributes['date'] + '     hui');
    Post post = new Post(
        Profile(attributes['nickName'],
            avatarImagePath: attributes['avatarImagePath']),
        DateTime.parse(attributes['date']),
        123);
    post.imageID = attributes['imageID'];
    //post.usersLiked = new Set.from(attributes['usersLiked']);
    return post;
  }
}

import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:picturn/Models/profile.dart';
import 'package:picturn/runtime_data.dart';

class Post {
  final Profile profile;
  final DateTime date;

  int likesCount;
  String imageID;
  bool isLiked;
  Set eMailUsersLiked = {};
  DatabaseReference id;
  File imageFile;

  Post(this.profile, this.date, {this.isLiked = false});

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
      'date': formatDate(
          this.date, [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]),
      'eMailUsersLiked': this.eMailUsersLiked.toList(),
      'eMail': this.profile.eMail,
    };
  }

  static Post createPostFromJson(record) {
    Map<String, dynamic> attributes = {
      'imageID': '',
      'nickName': '',
      'avatarImagePath': '',
      'date': '',
      'eMailUsersLiked': [],
      'eMail': '',
    };

    print(record.toString());

    record.forEach((key, value) => {attributes[key] = value});

    Post post = new Post(
        Profile(attributes['nickName'], attributes['eMail'],
            avatarImagePath: attributes['avatarImagePath']),
        DateTime.parse(attributes['date']),);
    post.imageID = attributes['imageID'];
    try {
      post.eMailUsersLiked = new Set.from(attributes['eMailUsersLiked']);
      post.isLiked = post.eMailUsersLiked.contains(
          RuntimeData.currentUserProfileViewModel.profile.eMail);
      post.likesCount = post.eMailUsersLiked.length;
    }
    catch(_){
      post.isLiked = false;
      post.likesCount = 0;
    }
    return post;
  }
}

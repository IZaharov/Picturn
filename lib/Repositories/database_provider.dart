import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:picturn/Models/post.dart';
import 'package:path/path.dart' as Path;

class DatabaseProvider {
  final databaseReference = FirebaseDatabase.instance.reference();

  DatabaseReference addPost(Post post) {
    var id = databaseReference.child('posts/').push();
    post.setId(id);
    id.set(post.toJson());
    return id;
  }

  Future<List<Post>> getAllPosts() async {
    DataSnapshot dataSnapshot = await databaseReference.child('posts/').once();
    List<Post> posts = [];
    print('qqqqqqqqqqqqqqqq');
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, value) {
        print("ASDGSDGSGSDGSDFGASFASFADFSDGASDFASFASFADFAFD");
        Post post = Post.createPostFromJson(value);
        post.setId(databaseReference.child('posts/' + key));
        posts.add(post);
        print(post.profile.nickName);
        //print(formatDate(post.date, [yyyy, '-', mm, '-', dd]));
      });
    }
    return posts;
  }
}

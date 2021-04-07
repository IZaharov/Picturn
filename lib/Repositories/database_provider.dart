import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:picturn/Models/post.dart';
import 'package:path/path.dart' as Path;

class DatabaseProvider {
  final databaseReference = FirebaseDatabase.instance.reference();
  final String _childPosts = 'posts/';

  DatabaseReference addPost(Post post) {
    var id = databaseReference.child(_childPosts).push();
    post.setId(id);
    id.set(post.toJson());
    return id;
  }

  Future<List<Post>> getAllPosts() async {
    DataSnapshot dataSnapshot = await databaseReference.child(_childPosts).once();
    return _getPosts(dataSnapshot);
  }

  Future<List<Post>> getProfilePosts(String eMail) async {
     DataSnapshot dataSnapshot = await databaseReference.child(_childPosts).orderByChild("eMail").equalTo(eMail).once();
     return _getPosts(dataSnapshot);
  }

  List<Post> _getPosts(DataSnapshot dataSnapshot) {
    List<Post> posts = [];
    if (dataSnapshot.value != null) {
      dataSnapshot.value.forEach((key, value) {
        Post post = Post.createPostFromJson(value);
        post.setId(databaseReference.child(_childPosts + key));
        posts.add(post);
      });
    }
    posts.sort((a, b) => b.date.compareTo(a.date));
    return posts;
  }

  void updatePost(Post post) async {
    await databaseReference.child(_childPosts+ post.imageID).update(post.toJson());
  }
}

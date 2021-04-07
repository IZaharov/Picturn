import 'dart:io';

import 'package:picturn/Models/post.dart';
import 'package:picturn/Repositories/post_repository.dart';
import 'package:picturn/runtime_data.dart';

class AddingPostViewModel{
  Future<void> addPost(File imageFile) async{
    Post post = Post(RuntimeData.currentUserProfileViewModel.profile, DateTime.now());
    post.setImageFile(imageFile);
    PostRepository().addPost(post);
  }
}
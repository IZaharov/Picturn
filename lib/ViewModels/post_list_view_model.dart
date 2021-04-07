import 'package:flutter/cupertino.dart';
import 'package:picturn/Models/post.dart';
import 'package:picturn/Repositories/post_repository.dart';
import 'package:picturn/ViewModels/post_view_model.dart';
import 'package:picturn/ViewModels/profile_view_model.dart';

enum PostListType { all, profile }

class PostListViewModel extends ChangeNotifier {
  // ignore: deprecated_member_use
  List<PostViewModel> postViewModels = List<PostViewModel>();
  PostListType _type;
  ProfileViewModel profileViewModel;

  PostRepository _postRepository = PostRepository();

  PostListViewModel(this._type, {this.profileViewModel});

  Future<void> fetchPosts() async {
    List<Post> results;

    switch (this._type) {
      case PostListType.all:
        results = await this._postRepository.fetchPosts();
        break;
      case PostListType.profile:
        results = await this
            ._postRepository
            .fetchProfilePosts(this.profileViewModel.profile.nickName);
        break;
    }
    this.postViewModels +=
        results.map((item) => PostViewModel(post: item)).toList();
    notifyListeners();
  }

  refreshPosts() {
    this.postViewModels.clear();
    fetchPosts();
    notifyListeners();
  }
}

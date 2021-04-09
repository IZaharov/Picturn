import 'package:picturn/Models/post.dart';
import 'package:picturn/runtime_data.dart';

import 'database_provider.dart';
import 'storage_provider.dart';

class PostRepository {
  var databaseProvider = DatabaseProvider();
  var storageProvider = StorageProvider();

  Future<void> addPost(Post post) async {
    this.databaseProvider.addPost(post);
    await this.storageProvider.uploadImageInStorage(post.imageFile, post.id.key);
  }

  Future<List<Post>> fetchPosts() async {
    return await this.databaseProvider.getAllPosts();
  }

  Future<List<Post>> fetchProfilePosts(String eMail) async {
    return await this.databaseProvider.getProfilePosts(eMail);
  }

  Future<bool> sendPostLikes(Post post) async {
    print('сервер получил лайк');

    if(post.isLiked)
      post.eMailUsersLiked.add(RuntimeData.currentUserProfileViewModel.profile.eMail);
    else
      post.eMailUsersLiked.remove(RuntimeData.currentUserProfileViewModel.profile.eMail);

    databaseProvider.updatePost(post);

    return await Future.delayed(Duration(seconds: 0), () => true);
  }

  Future<String> getImagePath(String id) async {
    return await storageProvider.getImagePath(id);
  }
}

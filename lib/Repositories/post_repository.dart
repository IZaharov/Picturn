import 'package:picturn/Models/post.dart';

import 'database_provider.dart';
import 'storage_provider.dart';

class PostRepository {
  var databaseProvider = DatabaseProvider();
  var storageProvider = StorageProvider();

  Future<void> addPost(Post post) async {
    this.databaseProvider.addPost(post);
    this.storageProvider.uploadImageInStorage(post.imageFile, post.id.key);
  }

  Future<List<Post>> fetchPosts() async {
    return await this.databaseProvider.getAllPosts();
  }

  Future<List<Post>> fetchProfilePosts(String nickName) async {
    return await this.databaseProvider.getProfilePosts(nickName);
  }

  Future<bool> sendPostLikes(
      String imagePath, String nickName, bool isLiked) async {
    //TODO запрос на добавление/удаление лайка пользователя к посту
    print('сервер получил лайк');
    return await Future.delayed(Duration(seconds: 0), () => true);
  }

  Future<int> fetchPostLikes(String imagePath) async {
    //TODO get запрос получения кол-ва лайков поста
    int count = await Future.delayed(Duration(seconds: 0), () => 15);
    return count;
  }

  Future<String> getImagePath(String id) async {
    return await storageProvider.getImagePath(id);
  }
}

import 'package:picturn/Models/post.dart';
import 'package:picturn/Repositories/post_repository.dart';

class AddingPostViewModel{
  Future<void> addPost(Post post) async{
    PostRepository().addPost(post);
  }
}
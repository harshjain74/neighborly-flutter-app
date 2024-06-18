import 'package:neighborly_flutter_app/features/posts/data/model/post_model.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<void> reportPost({required String reason, required num postId});
}
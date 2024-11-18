import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/post/domain/entity/post.dart';
import 'package:social_media/features/post/presentation/cubits/post_state.dart';

import '../../../storage/domain/storage_repo.dart';
import '../../domain/repos/post_repo.dart';

class PostCubit extends Cubit<PostState> {
  final PostRepo postRepo;
  final StorageRepo storageRepo;

  PostCubit({required this.postRepo, required this.storageRepo})
      : super(PostInitial());

  // create a new post
  Future<void> createPost(Post post,
      {String? imagePath, Uint8List? imageBytes}) async {
    String? imageUrl;
    try {
      if (imagePath != null) {
        emit(PostUploading());
        // upload img path for mobile
        imageUrl =
            await storageRepo.uploadProfileImageMobile(imagePath, post.id);
      } else if (imageBytes != null) {
        emit(PostUploading());
        // upload img bytes for web.
        imageUrl = await storageRepo.uploadProfileImageWeb(imageBytes, post.id);
      }

      // assign img url
      final newPost = post.copyWith(imageUrl: imageUrl);

      // save new post.
      postRepo.createPost(newPost);

      await fetchAllPost();
    } catch (e) {
      emit(PostError("Error create post: $e"));
    }
  }

  // fetch all post
  Future<void> fetchAllPost() async {
    try {
      emit(PostLoading());
      final posts = await postRepo.fetchAllPosts();
      emit(PostLoaded(posts));
    } catch (e) {
      emit(PostError("Error fetching posts $e"));
    }
  }

  // delete posts
  Future<void> deletePost(String postId) async {
    try {
      await postRepo.deletePost(postId);
    } catch (e) {
      emit(PostError("Error delete post $e"));
    }
  }
}

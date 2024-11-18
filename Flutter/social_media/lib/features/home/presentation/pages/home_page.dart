import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/home/presentation/components/my_drawer.dart';
import 'package:social_media/features/home/presentation/components/post_tile.dart';
import 'package:social_media/features/post/presentation/cubits/post_cubit.dart';
import 'package:social_media/features/post/presentation/cubits/post_state.dart';

import '../../../post/presentation/pages/upload_post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final postCubit = context.read<PostCubit>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchAllPost() {
    postCubit.fetchAllPost();
  }

  void deletePost(String postId) {
    postCubit.deletePost(postId);
    fetchAllPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UploadPostPage()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<PostCubit, PostState>(
        builder: (context, state) {
          if (state is PostLoading || state is PostUploading) {
            // loading
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PostLoaded) {
            // loaded
            final posts = state.posts;
            if (posts.isEmpty) {
              return const Center(
                child: Text('No post.'),
              );
            } else {
              return ListView.builder(
                  itemCount: posts.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    var post = posts[index];
                    return PostTile(
                      post: post,
                      deletePost: () => deletePost(post.id),
                    );
                  });
            }
          } else if (state is PostError) {
            // error
            return Center(
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      drawer: const MyDrawer(),
    );
  }
}

import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/auth/domain/entity/app_user.dart';
import 'package:social_media/features/post/domain/entity/post.dart';
import 'package:social_media/features/post/presentation/cubits/post_cubit.dart';
import 'package:social_media/features/profile/domain/entity/profile_user.dart';

import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../../../profile/presentation/cubits/profile_cubit.dart';

class PostTile extends StatefulWidget {
  final Post post;
  final void Function()? deletePost;

  const PostTile({super.key, required this.post, this.deletePost});

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  late final postCubit = context.read<PostCubit>();
  late final profileCubit = context.read<ProfileCubit>();
  late final authCubit = context.read<AuthCubit>();

  AppUser? currentUser;
  ProfileUser? postUser;
  bool isOwnPost = false;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchPostUser();
  }

  void getCurrentUser() {
    currentUser = authCubit.currentUser;
    isOwnPost = currentUser?.uid == widget.post.userId;
  }

  void fetchPostUser() async {
    final postUserFetch = await profileCubit.getUserProfile(widget.post.userId);
    setState(() {
      postUser = postUserFetch;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          // top section.
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                postUser?.profileImageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: postUser!.profileImageUrl,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person),
                        imageBuilder: (context, imageProvider) => Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                      )
                    : const Icon(Icons.person),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  widget.post.username,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (isOwnPost)
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: widget.deletePost,
                  ),
              ],
            ),
          ),
          CachedNetworkImage(
            imageUrl: widget.post.imageUrl,
            width: double.infinity,
            height: 430,
            fit: BoxFit.cover,
            placeholder: (context, url) => const SizedBox(
              height: 430,
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),

          // buttons: like, comment, timestamp.
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // like btn
                const Icon(Icons.favorite_border),
                const Text('0'),
                const SizedBox(
                  width: 20,
                ),

                // comment btn
                const Icon(Icons.comment),
                const Text('0'),
                
                const Spacer(),

                // timestamp
                Text(widget.post.timestamp.toString())
              ],
            ),
          )
        ],
      ),
    );
  }
}

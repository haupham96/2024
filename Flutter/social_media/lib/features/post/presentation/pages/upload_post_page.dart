import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/auth/domain/entity/app_user.dart';
import 'package:social_media/features/auth/presentation/components/my_text_field.dart';
import 'package:social_media/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media/features/post/domain/entity/post.dart';
import 'package:social_media/features/post/presentation/cubits/post_cubit.dart';
import 'package:social_media/features/post/presentation/cubits/post_state.dart';
import 'package:social_media/features/profile/presentation/cubits/profile_state.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  // mobile file pick
  PlatformFile? imgPicked;

  // web img bytes
  Uint8List? imgBytes;

  // current user
  AppUser? currentUser;

  // caption
  final TextEditingController captionController = TextEditingController();

  // create and upload post.
  void uploadPost() {
    if (imgPicked == null || captionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("image and caption are required.")));
      return;
    }

    Post newPost = Post(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: currentUser!.uid,
        username: currentUser!.name,
        text: captionController.text,
        imageUrl: '',
        timestamp: DateTime.now(),
        likes: []);

    // post cubit
    final postCubit = context.read<PostCubit>();

    // upload img
    if (kIsWeb) {
      postCubit.createPost(newPost, imageBytes: imgPicked?.bytes);
    } else {
      postCubit.createPost(newPost, imagePath: imgPicked?.path);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  // pick image
  Future<void> pickImage() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: kIsWeb);

    if (result != null) {
      setState(() {
        imgPicked = result.files.first;
        if (kIsWeb) {
          imgBytes = imgPicked!.bytes;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostCubit, PostState>(
      builder: (context, state) {
        print(state);
        // loading state
        if (state is PostLoading || state is PostUploading) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Create Post'),
              centerTitle: true,
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
            body: const CircularProgressIndicator(),
          );
        }

        return _buildPostPage();
      },
      listener: (context, state) {
        // go to previous page when upload is done and post is loaded
        if (state is PostLoaded) {
          Navigator.of(context).pop();
        }
      },
    );
  }

  Widget _buildPostPage() {
    return Scaffold(
      // APPBAR
      appBar: AppBar(
        title: const Text('Create Post'),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(onPressed: uploadPost, icon: const Icon(Icons.upload))
        ],
      ),

      // BODY
      body: Center(
        child: Column(
          children: [
            // img preview for web
            if (kIsWeb && imgBytes != null) Image.memory(imgBytes!),

            // img preview for mobile
            if (!kIsWeb && imgPicked != null)
              Image.file(File(imgPicked!.path!)),

            // button picked image
            MaterialButton(
              onPressed: pickImage,
              color: Colors.blue,
              child: const Text('Pick Image'),
            ),

            // caption text box
            MyTextField(
                controller: captionController,
                hintText: 'Caption',
                obscureText: false)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

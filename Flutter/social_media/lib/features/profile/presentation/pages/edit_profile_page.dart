import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/auth/presentation/components/my_text_field.dart';
import 'package:social_media/features/profile/domain/entity/profile_user.dart';
import 'package:social_media/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_media/features/profile/presentation/cubits/profile_state.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;

  const EditProfilePage({super.key, required this.user});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Mobile image pick up.
  PlatformFile? imagePickedFile;

  // Web pick up
  Uint8List? webImage;

  // bio text controller.
  final bioController = TextEditingController();

  // pick image
  Future<void> pickImage() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: kIsWeb);

    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;
        if (kIsWeb) {
          webImage = imagePickedFile!.bytes;
        }
      });
    }
  }

  void updateProfile() async {
    // profile cubit
    final profileCubit = context.read<ProfileCubit>();

    // prepare image
    String uid = widget.user.uid;
    String? imageMobilePath = kIsWeb ? null : imagePickedFile?.path;
    Uint8List? imgWebBytes = kIsWeb ? imagePickedFile?.bytes : null;
    String? newBio = bioController.text.isNotEmpty ? bioController.text : null;
    if (bioController.text.isNotEmpty || imagePickedFile != null) {
      profileCubit.updateProfile(
          uid: uid,
          newBio: newBio,
          imgMobilePath: imageMobilePath,
          imgWebBytes: imgWebBytes);
    } else {
      // Nothing to update -> go back to previous page.
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        // profile loading
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text('Profile uploading ....')
                ],
              ),
            ),
          );
        } else {
          // edit form
          return buildEditPage();
        }
      },
      listener: (context, state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildEditPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
        ),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(onPressed: updateProfile, icon: const Icon(Icons.upload))
        ],
      ),
      body: Column(
        children: [
          // profile picture
          Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.secondary),
              clipBehavior: Clip.hardEdge,
              child: (!kIsWeb && imagePickedFile != null)
                  // if mobile -> display file from path.
                  ? Image.file(
                      File(imagePickedFile!.path!),
                      fit: BoxFit.cover,
                    )
                  // if web -> display file from bytes.
                  : (kIsWeb && webImage != null)
                      ? Image.memory(webImage!, fit: BoxFit.cover)
                      : CachedNetworkImage(
                          imageUrl: widget.user.profileImageUrl,
                          // loading ..
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          // on error handler
                          errorWidget: (context, url, error) => Icon(
                            Icons.person,
                            size: 72,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          imageBuilder: (context, imageProvider) =>
                              Image(image: imageProvider, fit: BoxFit.cover),
                        ),
            ),
          ),
          // pick image button
          Center(
            child: MaterialButton(
              onPressed: pickImage,
              color: Colors.blue,
              child: const Text("Pick image"),
            ),
          ),

          // profile bio
          const Text("Bio"),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextField(
                controller: bioController,
                hintText: widget.user.bio,
                obscureText: false),
          )
        ],
      ),
    );
  }
}

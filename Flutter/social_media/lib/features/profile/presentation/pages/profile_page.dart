import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media/features/profile/presentation/components/bio_box.dart';
import 'package:social_media/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_media/features/profile/presentation/cubits/profile_state.dart';

import '../../../auth/domain/entity/app_user.dart';
import '../../../home/presentation/components/my_drawer.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final AuthCubit authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  late AppUser? currentUser = authCubit.currentUser;

  @override
  void initState() {
    super.initState();

    // load user
    profileCubit.fetchUserProfile(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(builder: (context, state) {
      if (state is ProfileLoaded) {
        final user = state.profileUser;
        return Scaffold(
          appBar: AppBar(
            title: Text(user.name),
            centerTitle: true,
            foregroundColor: Theme.of(context).colorScheme.primary,
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                            user: user,
                          ),
                        ));
                  },
                  icon: const Icon(Icons.settings))
            ],
          ),
          body: Column(
            children: [
              // email
              Text(
                user.email,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(
                height: 25,
              ),
              // profile pic
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.secondary),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: user.profileImageUrl,
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
              const SizedBox(
                height: 25,
              ),
              // bio box
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Text("Bio",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BioBox(
                text: user.bio,
              ),
              const SizedBox(
                height: 25,
              ),
              // post
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Text("Posts",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary)),
                  ],
                ),
              ),
            ],
          ),
        );
      } else if (state is ProfileLoading) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      } else {
        return const Scaffold(
          body: Center(
            child: Text("No Profile found ..."),
          ),
        );
      }
    });
  }
}

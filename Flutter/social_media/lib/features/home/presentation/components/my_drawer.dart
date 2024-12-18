import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/home/presentation/components/my_drawer_title.dart';

import '../../../auth/presentation/cubits/auth_cubit.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),
              // home tile
              MyDrawerTitle(
                  title: "H O M E",
                  icon: Icons.home,
                  onTap: () {
                    Navigator.of(context).pop();
                  }),
              // profile tile
              MyDrawerTitle(
                  title: "P R O F I L E",
                  icon: Icons.person,
                  onTap: () {
                    // pop menu drawer
                    Navigator.pop(context);
                    
                    final user = context.read<AuthCubit>().currentUser;
                    
                    // navigate to profile page.
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage(uid: user!.uid)));
                  }),
              // search tile
              MyDrawerTitle(
                  title: "S E A R C H", icon: Icons.search, onTap: () {}),
              // settings tile
              MyDrawerTitle(
                  title: "S E T T I N G S", icon: Icons.settings, onTap: () {}),
              // logout tile
              const Spacer(),
              MyDrawerTitle(
                  title: "L O G O U T",
                  icon: Icons.logout,
                  onTap: () {
                    final authCubit = context.read<AuthCubit>();
                    authCubit.logout();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/auth/data/firebase_auth_repo.dart';
import 'package:social_media/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:social_media/features/auth/presentation/cubits/auth_state.dart';
import 'package:social_media/features/post/data/firebase_post_repo.dart';
import 'package:social_media/features/post/presentation/cubits/post_cubit.dart';
import 'package:social_media/features/profile/data/firebase_profile_repo.dart';
import 'package:social_media/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:social_media/features/storage/data/firebase_storage_repo.dart';
import 'package:social_media/themes/light_mode.dart';

import 'features/auth/presentation/pages/auth_page.dart';
import 'features/home/presentation/pages/home_page.dart';

/*
  ROOT Level of app
  Block Provider:  state management
   - auth
   - profile
   - post
   - search
   - theme
   
  repo: database
  - fire base
  
  Check Auth state.
  - unauthenticated => login/register page
  - authenticated => home page
 */
class MyApp extends StatelessWidget {
  final firebaseAuthRepo = FirebaseAuthRepo();
  final firebaseProfileRepo = FirebaseProfileRepo();
  final firebaseStorageRepo = FirebaseStorageRepo();
  final postRepo = FirebasePostRepo();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // auth cubit
        BlocProvider<AuthCubit>(
          create: (context) =>
              AuthCubit(authRepo: firebaseAuthRepo)..checkAuth(),
        ),
        // profile cubit
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(
              profileRepo: firebaseProfileRepo,
              storageRepo: firebaseStorageRepo),
        ),
        // posts cubit
        BlocProvider(
            create: (context) =>
                PostCubit(postRepo: postRepo, storageRepo: firebaseStorageRepo))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is Unauthenticated) {
              return const AuthPage();
            } else if (authState is Authenticated) {
              return const HomePage();
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
          listener: (context, authState) {
            // listen to errors.
            if (authState is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(authState.message)));
            }
          },
        ),
      ),
    );
  }
}

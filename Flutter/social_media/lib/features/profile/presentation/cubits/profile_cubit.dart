import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/profile/domain/entity/profile_user.dart';
import 'package:social_media/features/profile/presentation/cubits/profile_state.dart';

import '../../../storage/domain/storage_repo.dart';
import '../../repo/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  final StorageRepo storageRepo;

  ProfileCubit({required this.profileRepo, required this.storageRepo})
      : super(ProfileInitial());

  // fetch user
  Future<void> fetchUserProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final user = await profileRepo.fetchUserProfile(uid);
      if (user != null) {
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError("User not found"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // return user profile with user.uid
  Future<ProfileUser?> getUserProfile(String uid) async {
    return await profileRepo.fetchUserProfile(uid);
  }

  // update profile
  Future<void> updateProfile(
      {required String uid,
      String? newBio,
      Uint8List? imgWebBytes,
      String? imgMobilePath}) async {
    emit(ProfileLoading());

    try {
      final currentUser = await profileRepo.fetchUserProfile(uid);
      if (currentUser == null) {
        emit(ProfileError("Fail to fetch user to update"));
        return;
      }

      // profile picture update
      String? imageDownloadUrl;
      if (imgWebBytes != null || imgMobilePath != null) {
        if (imgMobilePath != null) {
          // for mobile
          imageDownloadUrl =
              await storageRepo.uploadProfileImageMobile(imgMobilePath, uid);
        } else if (imgWebBytes != null) {
          // for web
          imageDownloadUrl =
              await storageRepo.uploadProfileImageWeb(imgWebBytes, uid);
        }

        if (imageDownloadUrl == null) {
          emit(ProfileError("Fail to upload image"));
          return;
        }
      }

      // update new profile
      final updateUserProfile = currentUser.copyWith(
          newBio: newBio ?? currentUser.bio,
          newProfileImageUrl: imageDownloadUrl ?? currentUser.profileImageUrl);
      await profileRepo.updateProfile(updateUserProfile);

      // re-fetch new user profile.
      await fetchUserProfile(uid);
    } catch (e) {
      emit(ProfileError("Error update profile: $e"));
    }
  }
}

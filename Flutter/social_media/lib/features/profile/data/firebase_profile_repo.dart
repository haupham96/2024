import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/features/profile/domain/entity/profile_user.dart';
import 'package:social_media/features/profile/repo/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      final userDoc =
          await firebaseFirestore.collection("users").doc(uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          return ProfileUser(
              uid: userData['uid'],
              email: userData['email'],
              name: userData['name'],
              bio: userData['bio'] ?? '',
              profileImageUrl: userData['profileImageUrl'].toString());
        }
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updateProfile) async {
    Map<String, dynamic> jsonProfile = updateProfile.toJson();
    firebaseFirestore.collection("users").doc(updateProfile.uid).update({
      'bio': updateProfile.bio,
      'profileImageUrl': updateProfile.profileImageUrl
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/features/auth/domain/entity/app_user.dart';
import 'package:social_media/features/auth/repo/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> getCurrentUser() async {
    User? firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser != null) {
      return AppUser(
          uid: firebaseUser.uid, email: firebaseUser.email!, name: '');
    }
    return null;
  }

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return AppUser(uid: userCredential.user!.uid, email: email, name: '');
    } catch (ex) {
      throw Exception("unable to login: $ex");
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      AppUser appUser =
          AppUser(uid: userCredential.user!.uid, email: email, name: name);

      // store user in firestore
      await firebaseFirestore.collection("users")
          .doc(appUser.uid)
          .set(appUser.toJson());

      return appUser;
    } catch (ex) {
      throw Exception("unable to register: $ex");
    }
  }
}

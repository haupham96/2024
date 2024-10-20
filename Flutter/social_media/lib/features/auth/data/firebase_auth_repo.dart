import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media/features/auth/domain/entity/app_user.dart';
import 'package:social_media/features/auth/repo/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
      return AppUser(uid: userCredential.user!.uid, email: email, name: name);
    } catch (ex) {
      throw Exception("unable to register: $ex");
    }
  }
}

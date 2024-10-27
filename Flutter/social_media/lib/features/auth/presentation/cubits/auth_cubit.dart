import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/auth/presentation/cubits/auth_state.dart';

import '../../domain/entity/app_user.dart';
import '../../repo/auth_repo.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // check authenticated user
  void checkAuth() async {
    AppUser? curUser = await authRepo.getCurrentUser();
    if (curUser != null) {
      emit(Authenticated(curUser));
      _currentUser = curUser;
    } else {
      emit(Unauthenticated());
    }
  }

  // get cur user
  AppUser? get currentUser => _currentUser;

// login email + pass
  Future<void> loginWithEmailAndPw(String email, String password) async {
    try {
      emit(AuthLoading());
      AppUser? appUser = await authRepo.loginWithEmailPassword(email, password);
      if (appUser != null) {
        _currentUser = appUser;
        emit(Authenticated(appUser));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // register email + pass
  Future<void> registerWithEmailAndPw(
      String name, String email, String password) async {
    try {
      emit(AuthLoading());
      AppUser? appUser =
          await authRepo.registerWithEmailPassword(name, email, password);
      if (appUser != null) {
        _currentUser = appUser;
        emit(Authenticated(appUser));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }

  // logout
  Future<void> logout() async {
    _currentUser = null;
    authRepo.logout();
    emit(Unauthenticated());
  }
}

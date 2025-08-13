import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorials/core/services/preference_manager.dart';
import 'package:riverpod_tutorials/features/auth/model/user_model.dart';
import 'package:riverpod_tutorials/features/auth/repo/auth_repo.dart';

final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepo();
});

class AuthNotifier extends StateNotifier<AsyncValue<UserModel>> {
  final AuthRepo _authRepo;

  AuthNotifier(this._authRepo)
    : super(
        const AsyncValue.data(
          UserModel(
            id: 0,
            username: "",
            email: "",
            firstName: "",
            lastName: "",
            gender: "",
            image: "",
            accessToken: "",
            refreshToken: "",
          ),
        ),
      );
  Future<void> login(Map<String, dynamic> credentials) async {
    state = const AsyncValue.loading();
    try {
      final user = await _authRepo.postApiRequest(credentials);
      print(user);
      state = AsyncValue.data(user);
      PreferenceManager.instance.saveAccessToken(user.accessToken);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    await _authRepo.logout();
    state = AsyncValue.data(
      UserModel(
        accessToken: "",
        firstName: "",
        id: 0,
        username: '',
        email: '',
        lastName: '',
        gender: '',
        image: '',
        refreshToken: '',
      ),
    );
  }
}

// final isToken = StateProvider<bool>((ref) => false);

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserModel>>(
  (ref) => AuthNotifier(ref.watch(authRepoProvider)),
);

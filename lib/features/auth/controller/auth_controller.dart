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
      PreferenceManager.instance.saveAccessToken(user.accessToken);
      final AccessToken = PreferenceManager.instance.getAccessToken();
      print("savedAccessToken ____$AccessToken");
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

 
}

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<UserModel>>(
  (ref) => AuthNotifier(ref.watch(authRepoProvider)),
);

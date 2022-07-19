import 'package:quote_request_app/providers/auth/auth_state.dart';
import 'package:quote_request_app/repositories/auth_repository.dart';
import 'package:riverpod/riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._authRepository) : super(AuthInitial());

  final AuthRepository _authRepository;

  Future<void> login(Map<String, dynamic> credentials) async {
    state = AuthLoading();
    try {
      final user = await _authRepository.login(
        credentials['email'],
        credentials['password'],
      );
      state = AuthSuccess(user);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }

  Future<void> register(Map<String, dynamic> userData) async {
    state = AuthLoading();
    try {
      final user = await _authRepository.register(userData);
      state = AuthSuccess(user);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
}

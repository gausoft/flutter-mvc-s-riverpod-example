import 'package:riverpod/riverpod.dart';

import '../../../core/data_state.dart';
import '../services/auth_service.dart';

class AuthController extends StateNotifier<DataState> {
  AuthController(this._authService) : super(const DataState.initial());

  final AuthService _authService;

  Future<void> login(Map<String, dynamic> credentials) async {
    state = const DataState.loading();
    try {
      final user = await _authService.login(
        credentials['email'],
        credentials['password'],
      );
      state = DataState.success(data: user);
    } catch (e) {
      state = DataState.error(message: e.toString());
    }
  }

  Future<void> register(Map<String, dynamic> userData) async {
    state = const DataState.loading();
    try {
      final user = await _authService.register(userData);
      state = DataState.success(data: user);
    } catch (e) {
      state = DataState.error(message: e.toString());
    }
  }
}

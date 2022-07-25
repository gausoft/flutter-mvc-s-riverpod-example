import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/user_model.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.success(UserModel user) = _Loaded;
  const factory AuthState.error(String message) = _Error;
}
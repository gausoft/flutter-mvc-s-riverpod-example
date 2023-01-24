import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_state.freezed.dart';

@freezed
class DataState<T> with _$DataState<T> {
  const factory DataState.initial() = _Initial;
  const factory DataState.loading() = _Loading;
  const factory DataState.success({required T data}) = _Success;
  const factory DataState.error({
    required String message,
    StackTrace? stackTrace,
  }) = _Error;
}

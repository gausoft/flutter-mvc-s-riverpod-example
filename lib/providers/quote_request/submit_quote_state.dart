import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/quote_model.dart';

part 'submit_quote_state.freezed.dart';

@freezed
class SubmitQuoteState with _$SubmitQuoteState {
  const factory SubmitQuoteState.initial() = _Initial;
  const factory SubmitQuoteState.loading() = _Loading;
  const factory SubmitQuoteState.success(Quote quote) = _Success;
  const factory SubmitQuoteState.error(String message) = _Error;
}
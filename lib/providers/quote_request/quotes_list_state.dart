import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/quote_model.dart';

part 'quotes_list_state.freezed.dart';

@freezed
class QuotesListState with _$QuotesListState {
  const factory QuotesListState.initial() = _Initial;
  const factory QuotesListState.loading() = _Loading;
  const factory QuotesListState.success(List<Quote> quotes) = _Success;
  const factory QuotesListState.error(String message) = _Error;
}
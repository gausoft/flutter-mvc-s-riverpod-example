import 'package:riverpod/riverpod.dart';

import '../repositories/quote_repository.dart';
import 'quotes_list_notifier.dart';
import 'submit_quote_state.dart';

class SubmitQuoteNotifier extends StateNotifier<SubmitQuoteState> {
  SubmitQuoteNotifier(this._repository, this.quotesListNotifier)
      : super(SubmitQuoteInitial());

  final QuoteRepository _repository;
  final QuotesListNotifier quotesListNotifier;

  Future<void> submitQuote(Map<String, dynamic> data) async {
    try {
      state = SubmitQuoteLoading();
      final quote = await _repository.submitQuote(data);
      quotesListNotifier.addQuote(quote);
      state = SubmitQuoteSuccess(quote);
    } on Exception catch (err) {
      state = SubmitQuoteError(err.toString());
    }
  }
}

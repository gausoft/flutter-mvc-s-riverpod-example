import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/quote_model.dart';
import '../repositories/quote_repository.dart';
import 'quotes_list_state.dart';

class QuotesListNotifier extends StateNotifier<QuotesListState> {
  QuotesListNotifier(this._repository) : super(const QuotesListInitial());

  final QuoteRepository _repository;

  Future<void> getQuotes() async {
    try {
      state = const QuotesListLoading();
      final List<Quote> quotes = await _repository.getQuotes();
      state = QuotesListLoaded(quotes);
    } on Exception catch (err) {
      state = QuotesListError(err.toString());
    }
  }

  void addQuote(Quote quote) {
    final currentState = state;
    if (currentState is QuotesListLoaded) {
      state = QuotesListLoaded([quote] + currentState.quotes);
    }
  }

  Future<void> delete(int quoteId) async {
    try {
      await _repository.deleteRequestedQuote(quoteId);

      final currentState = state;
      if (currentState is QuotesListLoaded) {
        state = QuotesListLoaded(
          currentState.quotes.where((quote) => quote.id != quoteId).toList(),
        );
      }
    } catch (e) {
      state = QuotesListError(e.toString());
      throw Exception(e.toString());
    }
  }
}

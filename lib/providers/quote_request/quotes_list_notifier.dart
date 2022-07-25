import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/quote_model.dart';
import '../../repositories/quote_repository.dart';
import 'quotes_list_state.dart';

class QuotesListNotifier extends StateNotifier<QuotesListState> {
  QuotesListNotifier(this._repository) : super(const QuotesListState.initial());

  final QuoteRepository _repository;

  Future<void> getQuotes() async {
    try {
      state = const QuotesListState.loading();
      final List<Quote> quotes = await _repository.getQuotes();
      state = QuotesListState.success(quotes);
    } on Exception catch (err) {
      state = QuotesListState.error(err.toString());
    }
  }

  void addQuote(Quote quote) {
    final currentState = state;
    state = QuotesListState.success(
      [quote] +
          currentState.maybeWhen(
            success: (quotes) => quotes,
            orElse: () => [],
          ),
    );
  }

  Future<void> delete(int quoteId) async {
    try {
      await _repository.deleteRequestedQuote(quoteId);

      final currentState = state;
      state = QuotesListState.success(
        currentState.maybeWhen(
          success: (quotes) =>
              quotes.where((quote) => quote.id != quoteId).toList(),
          orElse: () => [],
        ),
      );
    } catch (e) {
      state = QuotesListState.error(e.toString());
      throw Exception(e.toString());
    }
  }
}

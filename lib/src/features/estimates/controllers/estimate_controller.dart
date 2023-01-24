import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/data_state.dart';
import '../models/quote_model.dart';
import '../services/estimate_service.dart';

class EstimateController extends StateNotifier<DataState> {
  EstimateController(this._estimateService) : super(const DataState.initial());

  final EstimateService _estimateService;

  List<Quote> _quotes = [];

  Future<void> getQuotes() async {
    state = const DataState.loading();
    try {
      _quotes = await _estimateService.getEstimates();
      state = DataState.success(data: _quotes);
    } on Exception catch (err) {
      state = DataState.error(message: err.toString());
    }
  }

  Future<void> submitQuote(Map<String, dynamic> data) async {
    state = const DataState.loading();
    try {
      final quote = await _estimateService.submitEstimate(data);
      _quotes.add(quote);
      state = DataState.success(data: _quotes);
    } on Exception catch (err) {
      state = DataState.error(message: err.toString());
    }
  }

  Future<void> delete(int id) async {
    try {
      await _estimateService.deleteEstimate(id);

      _quotes.removeWhere((quote) => quote.id == id);

      state = DataState.success(data: _quotes);
    } catch (e) {
      state = DataState.error(message: e.toString());
      throw Exception(e.toString());
    }
  }
}

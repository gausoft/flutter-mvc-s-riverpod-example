import 'package:dio/dio.dart';

import '../models/quote_model.dart';

abstract class QuoteRepository {
  Future<Quote> submitQuote(Map<String, dynamic> quote);
  Future<List<Quote>> getQuotes();
  Future<void> deleteRequestedQuote(int requestedQuoteId);
}

class QuoteRepositoryImpl implements QuoteRepository {
  final Dio _dio;

  QuoteRepositoryImpl(this._dio);

  @override
  Future<void> deleteRequestedQuote(int requestedQuoteId) async {
    try {
      await _dio.delete(
        '/requests',
        queryParameters: {'id': 'eq.$requestedQuoteId'}, //check PostgREST docs
      );
    } catch (_) {
      throw Future.error("Couldn't delete quote. Is the device online?");
    }
  }

  @override
  Future<List<Quote>> getQuotes() async {
    try {
      final response = await _dio.get('/requests', queryParameters: {
        'order': 'created_at.desc',
      });

      return (response.data as List<dynamic>)
          .map((e) => Quote.fromMap(e))
          .toList();
    } catch (_) {
      throw Future.error("Couldn't fetch quotes. Is the device online?");
    }
  }

  @override
  Future<Quote> submitQuote(Map<String, dynamic> quote) async {
    try {
      final response = await _dio.post('/requests', data: quote);

      if (response.statusCode == 201) {
        return Quote.fromMap(response.data[0]);
      } else {
        throw Exception('Error submitting request quote');
      }
    } catch (_) {
      throw Future.error("Couldn't submit quote. Is the device online?");
    }
  }
}

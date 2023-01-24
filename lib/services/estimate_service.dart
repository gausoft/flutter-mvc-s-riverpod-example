import 'package:dio/dio.dart';

import '../models/quote_model.dart';

class EstimateService {
  final Dio _dio;

  EstimateService(this._dio);

  Future<List<Quote>> getEstimates() async {
    try {
      final response = await _dio.get('/rest/v1/requests', queryParameters: {
        'order': 'created_at.desc',
      });

      return (response.data as List<dynamic>)
          .map((e) => Quote.fromJson(e))
          .toList();
    } catch (_) {
      throw Exception("Couldn't fetch quotes. Is the device online?");
    }
  }

  Future<Quote> submitEstimate(Map<String, dynamic> quote) async {
    try {
      final response = await _dio.post('/rest/v1/requests', data: quote);

      if (response.statusCode == 201) {
        return Quote.fromJson(response.data.first);
      } else {
        throw Exception('Error submitting request quote');
      }
    } catch (_) {
      throw Exception("Couldn't submit quote. Is the device online?");
    }
  }

  Future<void> deleteEstimate(int estimateId) async {
    try {
      await _dio.delete(
        '/rest/v1/requests',
        queryParameters: {'id': 'eq.$estimateId'},
      );
    } catch (_) {
      throw Exception("Couldn't delete estimate. Is the device online?");
    }
  }
}

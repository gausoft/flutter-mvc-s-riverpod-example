import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(Map<String, dynamic> userData);
}

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio;

  AuthRepositoryImpl(this._dio);

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/auth/v1/token',
        queryParameters: {'grant_type': 'password'},
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data['user']);
      } else {
        throw Exception('An error occurred');
      }
    } on DioError catch (e) {
      throw Exception(e.response!.data['error_description']);
    } catch (e) {
      throw Exception("Couldn't login. Is the device online?");
    }
  }

  @override
  Future<UserModel> register(Map<String, dynamic> userData) async {
    try {
      final response = await _dio.post('/auth/v1/signup', data: userData);
      return UserModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response!.statusCode == 400) {
        throw Exception(e.response!.data['error_description']);
      } else {
        throw Exception(e.message);
      }
    } catch (e, stack) {
      debugPrint('Error: $e\nStack : $stack');
      throw Exception("Couldn't register. Is the device online?");
    }
  }
}

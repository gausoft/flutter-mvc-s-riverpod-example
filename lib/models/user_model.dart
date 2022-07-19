import 'package:flutter/foundation.dart';

class UserModel {
  final String? uuid;
  final String email;
  final String? password;
  final String fullname;
  final String? address;

  UserModel({
    this.uuid,
    this.password,
    this.address,
    required this.email,
    required this.fullname,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uuid: json['id'],
      email: json['email'],
      fullname: json['user_metadata']['fullname'],
      address: json['user_metadata']['address'],
    );
  }
}

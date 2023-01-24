import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  @JsonSerializable(explicitToJson: true)
  const factory UserModel({
    String? uuid,
    String? password,
    // @JsonKey(name: 'address', fromJson: addressFromJson) String? address,
    required String email,
    // @JsonKey(name: 'fullname', fromJson: fullnameFromJson) required String fullname,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  static String fullnameFromJson(Map<String, dynamic> json) {
    return json['user_metadata']['fullname'] as String;
  }

  static String addressFromJson(Map<String, dynamic> json) {
    return json['user_metadata']['address'] as String;
  }
}

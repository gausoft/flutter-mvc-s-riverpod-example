import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_model.freezed.dart';
part 'quote_model.g.dart';

@freezed
class Quote with _$Quote {
  const factory Quote({
    int? id,
    @JsonKey(name: 'product_name') 
    required String productName,
    required String description,
    @JsonKey(name: 'product_link') 
    required String productLink,
    required int quantity,
    @JsonKey(name: 'created_at') 
    DateTime? createdAt,
  }) = _Quote;

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
}

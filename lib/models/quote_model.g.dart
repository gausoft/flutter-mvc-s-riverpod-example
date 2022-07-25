// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Quote _$$_QuoteFromJson(Map<String, dynamic> json) => _$_Quote(
      id: json['id'] as int?,
      productName: json['product_name'] as String,
      description: json['description'] as String,
      productLink: json['product_link'] as String,
      quantity: json['quantity'] as int,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$_QuoteToJson(_$_Quote instance) => <String, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'description': instance.description,
      'product_link': instance.productLink,
      'quantity': instance.quantity,
      'created_at': instance.createdAt?.toIso8601String(),
    };

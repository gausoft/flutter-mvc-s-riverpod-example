import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  const Quote({
    this.id,
    required this.productName,
    required this.description,
    required this.productLink,
    required this.quantity,
    this.createdAt,
  });

  final int? id;
  final String productName;
  final String description;
  final String productLink;
  final int quantity;
  final DateTime? createdAt;

  Quote copyWith({
    int? id,
    String? productName,
    String? description,
    String? productLink,
    int? quantity,
    DateTime? createdAt,
  }) {
    return Quote(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      productLink: productLink ?? this.productLink,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'],
      productName: map['product_name'] as String,
      description: map['description'] as String,
      productLink: map['product_link'] as String,
      quantity: int.parse('${map['quantity']}'),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_name': productName,
      'description': description,
      'product_link': productLink,
      'quantity': quantity,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        productName,
        description,
        productLink,
        quantity,
        createdAt,
      ];
}

import 'package:flutter/cupertino.dart';

class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final int? productPrice;
  final ValueNotifier<int>? quantity;

  Cart(
      {required this.id,
        required this.productId,
        required this.productName,
        required this.productPrice,
        required this.quantity,});

  Cart.fromMap(Map<dynamic, dynamic> data)
      : id = data['id'],
        productId = data['productId'],
        productName = data['productName'],
        productPrice = data['productPrice'],
        quantity = ValueNotifier(data['quantity']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity?.value,
    };
  }

}
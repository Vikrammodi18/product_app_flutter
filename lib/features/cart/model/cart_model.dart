

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';



@freezed 
abstract class CartModel with _$CartModel {
    const factory CartModel({
        required int id,
        required List<Product> products,
        required double total,
        required double discountedTotal,
        required int userId,
        required int totalProducts,
        required int totalQuantity,
    }) = _CartModel;

    factory CartModel.fromJson(Map<String, dynamic> json) => _$CartModelFromJson(json);
}

@freezed
abstract class Product with _$Product {
    const factory Product({
        required int id,
        required String title,
        required double price,
        required int quantity,
        required double total,
        required double discountPercentage,
        required double discountedTotal,
        required String thumbnail,
    }) = _Product;

    factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}

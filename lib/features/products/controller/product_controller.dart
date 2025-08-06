import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorials/features/products/model/product_model.dart';
import 'package:riverpod_tutorials/features/products/repo/product_repo.dart';

final productRepoProvider = Provider<ProductRepo>((ref) {
  return ProductRepo();
});

final productProvider = FutureProvider.autoDispose<ProductModel>((ref) async {
  final repo = ref.read(productRepoProvider);
  return await repo.fetchProduct();
});

final productDetailProvider = FutureProvider.family<Product,String>((ref,id) async {
  final repo = ref.read(productRepoProvider);
  return await repo.FetchProductDetails(id: id);
});

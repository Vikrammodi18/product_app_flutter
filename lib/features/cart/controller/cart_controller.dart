import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorials/features/cart/model/cart_model.dart';
import 'package:riverpod_tutorials/features/cart/repo/cart_repo.dart';

final cartRepoProvider = Provider<CartRepo>((ref) {
  return CartRepo();
});

final cartProviderController = FutureProvider.autoDispose((ref) async {
  final repo = ref.watch(cartRepoProvider);
  return await repo.fetchCartData();
});

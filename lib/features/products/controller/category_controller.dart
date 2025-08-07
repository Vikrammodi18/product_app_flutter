import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorials/features/products/model/category_model.dart';
import 'package:riverpod_tutorials/features/products/model/product_model.dart';
import 'package:riverpod_tutorials/features/products/repo/category_repo.dart';

final categoryRepo = Provider<CategoryRepo>((ref) {
  return CategoryRepo();
});
final selectedCategoryProvider = StateProvider<String?>((ref) => null);

final categoryProvider = FutureProvider.autoDispose<List<CategoryModel>>((
  ref,
) async {
  final repo = ref.read(categoryRepo);
  final categories = await repo.getCategories();
  final selected = ref.read(selectedCategoryProvider);
  if (selected == null && categories.isNotEmpty) {
    ref.read(selectedCategoryProvider.notifier).state = categories[0].slug;
  }
  return categories;
});

final categoryProductProvider = FutureProvider.family<ProductModel, String>((
  ref,
  categoryName,
) async {
  final repo = ref.read(categoryRepo);
  // final categoryList = repo.getCategories();

  return await repo.getCategoryProduct(categoryName);
});

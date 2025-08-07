import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorials/features/products/model/category_model.dart';
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
    ref.read(selectedCategoryProvider.notifier).state = categories[0].name;
  }
  return categories;
});

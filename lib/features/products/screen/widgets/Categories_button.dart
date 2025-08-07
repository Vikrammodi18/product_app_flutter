import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorials/features/products/controller/category_controller.dart';


class CategoriesButton extends ConsumerStatefulWidget {
  const CategoriesButton({super.key});

  @override
  ConsumerState<CategoriesButton> createState() => _CategoriesButtonState();
}

class _CategoriesButtonState extends ConsumerState<CategoriesButton> {
  @override
  Widget build(BuildContext context) {
    final categoryList = ref.watch(categoryProvider);
    final selectedCategory = ref.read(selectedCategoryProvider);

    return categoryList.when(
      data: (categories) {
        return SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = selectedCategory == category.slug;
              
              return ChoiceChip(
                elevation: 5.0,
                label: Text(category.name),
                selected: isSelected,
                onSelected: (_) {
                  ref.read(selectedCategoryProvider.notifier).state =
                      category.slug;
                  // call your filtered product fetch function here
                },
              );
            },
          ),
        );
      },
      error: (e, _) => Text("Error loading categories"),
      loading: () => CircularProgressIndicator(),
    );
  }
}

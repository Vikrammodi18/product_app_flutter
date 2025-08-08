import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorials/features/products/controller/category_controller.dart';
import 'package:riverpod_tutorials/features/products/controller/product_controller.dart';
import 'package:riverpod_tutorials/features/products/screen/searched_product.dart';
import 'package:riverpod_tutorials/features/products/screen/widgets/Categories_button.dart';
import 'package:riverpod_tutorials/features/products/screen/widgets/product_builder.dart';
import 'package:riverpod_tutorials/features/products/screen/widgets/search_widget.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryName = ref.watch(selectedCategoryProvider);
    // final productData = ref.watch(productProvider);

    final categoryProduct = ref.watch(
      categoryProductProvider(categoryName ?? "beauty"),
    );
    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              SearchWidget(),

              Consumer(
                builder: (context, ref, _) {
                  final searchQuery = ref.watch(searchQueryProvider);
                  return searchQuery.trim().isEmpty
                      ? Expanded(
                          child: Column(
                            children: [
                              CategoriesButton(),
                              categoryProduct.when(
                                data: (product) {
                                  return Expanded(
                                    child: ProductBuilder(
                                      product: product.products ?? [],
                                    ),
                                  );
                                },
                                error: (error, stack) =>
                                    Center(child: Text("error : $error")),
                                loading: () =>
                                    Center(child: CircularProgressIndicator()),
                              ),
                            ],
                          ),
                        )
                      : Expanded(child: SearchedProduct());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

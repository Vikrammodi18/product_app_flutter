import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorials/features/products/controller/product_controller.dart';
import 'package:riverpod_tutorials/features/products/screen/widgets/product_builder.dart';

class SearchedProduct extends ConsumerStatefulWidget {
  const SearchedProduct({super.key});

  @override
  ConsumerState<SearchedProduct> createState() => _SearchedProductState();
}

class _SearchedProductState extends ConsumerState<SearchedProduct> {
  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final searchProduct = ref.watch(searchProductProvider(searchQuery));
    return Scaffold(
      body: searchProduct.when(
        data: (product) {
          return ProductBuilder(product: product.products ?? []);
        },
        error: (error, stack) => Center(child: Text("error causing $error")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_tutorials/features/products/controller/product_controller.dart';
import 'package:riverpod_tutorials/features/products/model/product_model.dart';
import 'package:riverpod_tutorials/features/products/screen/widgets/product_card.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final productData = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: productData.when(
          data: (product) {
            return GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.75, // adjust for better layout
              ),
              itemCount: product.products?.length,
              itemBuilder: (context, index) {
                final productList = product.products![index];
                return InkWell(
                  onTap: () {
                    final String id = productList.id.toString();
                    context.push('/products/$id');
                  },
                  child: ProductCard(product: productList),
                );
              },
            );
          },
          error: (error, stack) => Center(child: Text("error : $error")),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

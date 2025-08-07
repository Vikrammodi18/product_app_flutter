// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:riverpod_tutorials/features/products/model/product_model.dart';
import 'package:riverpod_tutorials/features/products/screen/widgets/product_card.dart';

class ProductBuilder extends StatelessWidget {
  final List<Product> product;

  const ProductBuilder({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 items per row
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75, // adjust for better layout
      ),
      itemCount: product.length,
      itemBuilder: (context, index) {
        final productList = product![index];
        return InkWell(
          onTap: () {
            final String id = productList.id.toString();
            context.push('/products/$id');
          },
          child: ProductCard(product: productList),
        );
      },
    );
  }
}

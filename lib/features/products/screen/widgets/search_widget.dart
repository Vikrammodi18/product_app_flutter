import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorials/features/products/controller/product_controller.dart';

class SearchWidget extends ConsumerWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = TextEditingController();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "e.g. mobile",
        ),
        onChanged: (item) {
          ref.read(searchQueryProvider.notifier).state = item;
        },
      ),
    );
  }
}

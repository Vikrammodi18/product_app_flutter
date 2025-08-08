import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_tutorials/features/products/screen/cart_screen.dart';
import 'package:riverpod_tutorials/features/products/screen/category_screen.dart';
import 'package:riverpod_tutorials/features/products/screen/product_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = const [
      ProductScreen(),
      CategoryScreen(),
      CartScreen(),
    ];
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.white,
        activeColor: Colors.purple,
        color: const Color.fromARGB(255, 74, 74, 74),
        style: TabStyle.react, // You can change to `fixed`, `reactCircle`, etc.
        items: const [
          TabItem(icon: Icons.shopping_bag, title: 'Products'),
          TabItem(icon: Icons.category, title: 'Categories'),
          TabItem(icon: Icons.shopping_cart, title: 'Cart'),
        ],

        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      
    );
  }
}

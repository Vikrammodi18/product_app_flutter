import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_tutorials/features/products/screen/home_screen.dart';
import 'package:riverpod_tutorials/features/products/screen/product_details_screen.dart';
import 'package:riverpod_tutorials/features/products/screen/product_screen.dart';

final routesProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
        path: '/home',
        name: "/home",
        builder: (context, state) {
          return HomeScreen();
        },
      ),
      GoRoute(
        path: "/products",
        builder: (context, state) {
          return ProductScreen();
        },
      ),
      GoRoute(
        path: "/products/:id",
        builder: (context, state) {
          final id = state.pathParameters["id"];
          return ProductDetailsScreen(id: id!);
        },
      ),
    ],
  );
});

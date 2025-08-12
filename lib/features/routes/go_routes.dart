import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_tutorials/core/services/preference_manager.dart';
import 'package:riverpod_tutorials/features/auth/controller/auth_controller.dart';
import 'package:riverpod_tutorials/features/auth/screen/login_screen.dart';
import 'package:riverpod_tutorials/features/products/screen/home_screen.dart';
import 'package:riverpod_tutorials/features/products/screen/product_details_screen.dart';
import 'package:riverpod_tutorials/features/products/screen/product_screen.dart';

final routesProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);
  return GoRouter(
    initialLocation: '/home',
    redirect: (context, state) async {
      final token = PreferenceManager.instance.getAccessToken();
      final loggingIn = state.matchedLocation == "/login";
      if (token == null && !loggingIn) {
        return '/login';
      }
      if (token != null && loggingIn) {
        return "/home";
      }
      return null;
    },
    routes: [
      GoRoute(
        path: "/login",
        name: "/login",
        builder: (context, state) {
          return LoginScreen();
        },
      ),
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

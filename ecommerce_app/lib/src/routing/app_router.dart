import 'package:ecommerce_app/src/features/account/account_screen.dart';
import 'package:ecommerce_app/src/features/checkout/checkout_screen.dart';
import 'package:ecommerce_app/src/features/leave_review_page/leave_review_screen.dart';
import 'package:ecommerce_app/src/features/not_found/not_found_screen.dart';
import 'package:ecommerce_app/src/features/orders_list/orders_list_screen.dart';
import 'package:ecommerce_app/src/features/product_page/product_screen.dart';
import 'package:ecommerce_app/src/features/products_list/products_list_screen.dart';
import 'package:ecommerce_app/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  home,
  cart,
  orders,
  account,
  signIn,
  product,
  leaveReview,
  checkout
}

final goRouter = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
          path: '/',
          name: AppRoutes.home.name,
          builder: (context, state) => const ProductsListScreen(),
          routes: [
            GoRoute(
              path: 'cart',
              name: AppRoutes.cart.name,
              // builder will use the default page transitions
              // builder: (context, state) => const ShoppingCartScreen(),
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                fullscreenDialog: true,
                child: const ShoppingCartScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'checkout',
                  name: AppRoutes.checkout.name,
                  // builder will use the default page transitions
                  // builder: (context, state) => const ShoppingCartScreen(),
                  pageBuilder: (context, state) => MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const CheckoutScreen(),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: 'orders',
              name: AppRoutes.orders.name,
              // builder will use the default page transitions
              // builder: (context, state) => const ShoppingCartScreen(),
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                fullscreenDialog: true,
                child: const OrdersListScreen(),
              ),
            ),
            GoRoute(
              path: 'account',
              name: AppRoutes.account.name,
              // builder will use the default page transitions
              // builder: (context, state) => const ShoppingCartScreen(),
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                fullscreenDialog: true,
                child: const AccountScreen(),
              ),
            ),
            GoRoute(
              path: 'signIn',
              name: AppRoutes.signIn.name,
              // builder will use the default page transitions
              // builder: (context, state) => const ShoppingCartScreen(),
              pageBuilder: (context, state) => MaterialPage(
                key: state.pageKey,
                fullscreenDialog: true,
                child: const EmailPasswordSignInScreen(
                  formType: EmailPasswordSignInFormType.signIn,
                ),
              ),
            ),
            GoRoute(
                path: 'product/:id',
                name: AppRoutes.product.name,
                // builder will use the default page transitions
                builder: (context, state) {
                  final productId = state.pathParameters['id']!;
                  return ProductScreen(productId: productId);
                },
                routes: [
                  GoRoute(
                      path: 'review',
                      name: AppRoutes.leaveReview.name,
                      // builder will use the default page transitions
                      // builder: (context, state) => const ShoppingCartScreen(),
                      pageBuilder: (context, state) {
                        final productId = state.pathParameters['id']!;
                        return MaterialPage(
                          key: state.pageKey,
                          fullscreenDialog: true,
                          child: LeaveReviewScreen(
                            productId: productId,
                          ),
                        );
                      }),
                ]),
          ]),
    ],
    errorBuilder: (context, state) => const NotFoundScreen());

import 'dart:async';

import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductsRepository {
  // FakeProductsRepository._();
  // static FakeProductsRepository instance = FakeProductsRepository._();

  final List<Product> _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

// to test, can add in async:
  // Future<List<Product>> fetchProductsList() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   throw Exception('connection failed');
  //   return Future.value(_products);
  // }

  Future<List<Product>> fetchProductsList() {
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() {
    return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}

final productsRepoProvider = Provider<FakeProductsRepository>((ref) {
  // return FakeProductsRepository.instance;
  return FakeProductsRepository();
});

final productsListStreamProvider =
    StreamProvider.autoDispose<List<Product>>((ref) {
  debugPrint('FakeProductsRepository, productsliststreamprovider');
  final productsRepository = ref.watch(productsRepoProvider);
  return productsRepository.watchProductsList();
});

final productsListFutureProvider =
    FutureProvider.autoDispose<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepoProvider);
  return productsRepository.fetchProductsList();
});

final productProvider =
    StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  debugPrint('FakeProductsRepository, productsliststreamprovider, id: $id');
  ref.onDispose(() {
    debugPrint(
        'FakeProductsRepository, productsliststreamprovider, id: $id, disposed');
  });
  final link = ref.keepAlive();
  Timer(const Duration(seconds: 10), () {
    link.close();
  });
  final productsRepository = ref.watch(productsRepoProvider);
  return productsRepository.watchProduct(id);
});

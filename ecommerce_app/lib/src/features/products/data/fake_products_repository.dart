import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

class FakeProductsRepo {
  FakeProductsRepo._();
  static FakeProductsRepo instance = FakeProductsRepo._();

  final List<Product> _products = kTestProducts;

  List<Product> getProductsList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  Future<List<Product>> fetchProductsList() {
    return Future.value(_products);
  }

  Stream<List<Product>> watchProductsList() {
    return Stream.value(_products);
  }

  Stream<Product?> watchProduct(String id) {
    // below is what copilot said:
    // return Stream.value(_products.firstWhere((product) => product.id == id));
    return watchProductsList()
        .map((products) => products.firstWhere((product) => product.id == id));
  }
}

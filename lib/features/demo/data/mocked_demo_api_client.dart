import 'demo_api_client.dart';
import 'models/product.dto.dart';

part 'mocked_demo_api_client_repository.dart';

class MockedDemoApiClient implements DemoApiClient {
  final _mockProducts = _MockedDemoApiClientRepository.getProducts();

  @override
  Future<ProductsResponseDto> getProducts({int? skip, int? limit}) async {
    await Future.delayed(const Duration(seconds: 1));
    final start = skip ?? 0;
    final end = (limit != null) ? start + limit : _mockProducts.length;
    final products = _mockProducts.sublist(start, end > _mockProducts.length ? _mockProducts.length : end);
    return ProductsResponseDto(
      products: products,
      total: _mockProducts.length,
      skip: start,
      limit: limit ?? _mockProducts.length,
    );
  }

  @override
  Future<ProductDto> getProduct(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    final product = _mockProducts.firstWhere((p) => p.id == id);
    return product;
  }

  @override
  Future<ProductsResponseDto> searchProducts(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    final products =
        _mockProducts
            .where(
              (p) =>
                  p.title.toLowerCase().contains(query.toLowerCase()) ||
                  p.description.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
    return ProductsResponseDto(products: products, total: products.length, skip: 0, limit: products.length);
  }

  @override
  Future<ProductDto> addProduct(ProductDto product) async {
    await Future.delayed(const Duration(seconds: 1));
    final newProduct = product.copyWith(id: _mockProducts.length + 1);
    _mockProducts.add(newProduct);
    return newProduct;
  }

  @override
  Future<ProductDto> updateProduct(int id, ProductDto product) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _mockProducts.indexWhere((p) => p.id == id);
    if (index == -1) {
      throw Exception('Product not found');
    }
    final updatedProduct = product.copyWith(id: id);
    _mockProducts[index] = updatedProduct;
    return updatedProduct;
  }

  @override
  Future<void> deleteProduct(int id) async {
    await Future.delayed(const Duration(seconds: 1));
    _mockProducts.removeWhere((p) => p.id == id);
  }

  @override
  Future<ProductsResponseDto> getProductsByCategory(String category) async {
    await Future.delayed(const Duration(seconds: 1));
    final products = _mockProducts.where((p) => p.category == category).toList();
    return ProductsResponseDto(products: products, total: products.length, skip: 0, limit: products.length);
  }
}

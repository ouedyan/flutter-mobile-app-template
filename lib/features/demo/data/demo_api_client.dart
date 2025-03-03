import 'package:dio/dio.dart';

import 'models/product.dto.dart';

class DemoApiClient {
  final Dio _httpClient;

  DemoApiClient(this._httpClient);

  Future<ProductsResponseDto> getProducts({int? skip, int? limit}) async {
    final response = await _httpClient.get(
      '/products',
      queryParameters: {if (skip != null) 'skip': skip, if (limit != null) 'limit': limit},
    );
    return ProductsResponseDto.fromJson(response.data);
  }

  Future<ProductDto> getProduct(int id) async {
    final response = await _httpClient.get('/products/$id');
    return ProductDto.fromJson(response.data);
  }

  Future<ProductsResponseDto> searchProducts(String query) async {
    final response = await _httpClient.get('/products/search', queryParameters: {'q': query});
    return ProductsResponseDto.fromJson(response.data);
  }

  Future<ProductDto> addProduct(ProductDto product) async {
    final response = await _httpClient.post('/products/add', data: product.toJson());
    return ProductDto.fromJson(response.data);
  }

  Future<ProductDto> updateProduct(int id, ProductDto product) async {
    final response = await _httpClient.put('/products/$id', data: product.toJson());
    return ProductDto.fromJson(response.data);
  }

  Future<void> deleteProduct(int id) async {
    await _httpClient.delete('/products/$id');
  }

  Future<ProductsResponseDto> getProductsByCategory(String category) async {
    final response = await _httpClient.get('/products/category/$category');
    return ProductsResponseDto.fromJson(response.data);
  }
}

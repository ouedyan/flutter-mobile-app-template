import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../services/api/api_service.dart';
import 'models/product.dto.dart';

part 'products_provider.g.dart';

@riverpod
class Products extends _$Products {
  @override
  FutureOr<ProductsResponseDto> build({int page = 0, int size = 10}) async {
    final response = await ref.read(apiServiceProvider).demo.getProducts(skip: page * size, limit: size);
    return response;
  }
}

@riverpod
class InfiniteProducts extends _$InfiniteProducts {
  @override
  FutureOr<List<ProductsResponseDto>> build({int size = 10}) async {
    final products = await ref.watch(productsProvider(size: size).future);
    return [products];
  }

  Future<void> fetchNextPage() async {
    if (!state.hasValue || state.value!.last.skip + state.value!.last.limit >= state.value!.last.total) {
      return;
    }

    final nextPage = await ref.read(productsProvider(page: (state.value!.last.skip ~/ size) + 1, size: size).future);

    final previousState = await future;
    final updatedList = [...previousState, nextPage];
    state = AsyncValue.data(updatedList);
  }

  Future<void> refreshAll() async {
    ref.invalidate(productsProvider(page: 0, size: size));
    await future;
  }

  Future<void> deleteProduct(int id) async {
    await ref.read(apiServiceProvider).demo.deleteProduct(id);

    final previousState = await future;
    final updatedList =
        previousState.map((page) {
          return page.copyWith(
            products: page.products.where((product) => product.id != id).toList(),
            total: page.total - 1,
          );
        }).toList();

    state = AsyncValue.data(updatedList);
  }

  Future<ProductDto> addProduct(ProductDto product) async {
    final newProduct = await ref.read(apiServiceProvider).demo.addProduct(product);

    final previousState = await future;
    if (previousState.isEmpty) {
      state = AsyncValue.data([
        ProductsResponseDto(products: [newProduct], total: 1, skip: 0, limit: size),
      ]);
      return newProduct;
    }

    final firstPage = previousState.first;
    final updatedFirstPage = firstPage.copyWith(
      products: [newProduct, ...firstPage.products],
      total: firstPage.total + 1,
    );

    final updatedList = [updatedFirstPage, ...previousState.skip(1)];
    state = AsyncValue.data(updatedList);

    return newProduct;
  }
}

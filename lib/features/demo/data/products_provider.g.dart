// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsHash() => r'34898f12385917255d4890ca24f7ad283fb3f6ab';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$Products
    extends BuildlessAutoDisposeAsyncNotifier<ProductsResponseDto> {
  late final int page;
  late final int size;

  FutureOr<ProductsResponseDto> build({int page = 0, int size = 10});
}

/// See also [Products].
@ProviderFor(Products)
const productsProvider = ProductsFamily();

/// See also [Products].
class ProductsFamily extends Family<AsyncValue<ProductsResponseDto>> {
  /// See also [Products].
  const ProductsFamily();

  /// See also [Products].
  ProductsProvider call({int page = 0, int size = 10}) {
    return ProductsProvider(page: page, size: size);
  }

  @override
  ProductsProvider getProviderOverride(covariant ProductsProvider provider) {
    return call(page: provider.page, size: provider.size);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsProvider';
}

/// See also [Products].
class ProductsProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<Products, ProductsResponseDto> {
  /// See also [Products].
  ProductsProvider({int page = 0, int size = 10})
    : this._internal(
        () =>
            Products()
              ..page = page
              ..size = size,
        from: productsProvider,
        name: r'productsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$productsHash,
        dependencies: ProductsFamily._dependencies,
        allTransitiveDependencies: ProductsFamily._allTransitiveDependencies,
        page: page,
        size: size,
      );

  ProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.size,
  }) : super.internal();

  final int page;
  final int size;

  @override
  FutureOr<ProductsResponseDto> runNotifierBuild(covariant Products notifier) {
    return notifier.build(page: page, size: size);
  }

  @override
  Override overrideWith(Products Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductsProvider._internal(
        () =>
            create()
              ..page = page
              ..size = size,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        size: size,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<Products, ProductsResponseDto>
  createElement() {
    return _ProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsProvider &&
        other.page == page &&
        other.size == size;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, size.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductsRef on AutoDisposeAsyncNotifierProviderRef<ProductsResponseDto> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `size` of this provider.
  int get size;
}

class _ProductsProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<Products, ProductsResponseDto>
    with ProductsRef {
  _ProductsProviderElement(super.provider);

  @override
  int get page => (origin as ProductsProvider).page;
  @override
  int get size => (origin as ProductsProvider).size;
}

String _$infiniteProductsHash() => r'6c43d61b65417cc59c08f8c312912b4b5829d1cc';

abstract class _$InfiniteProducts
    extends BuildlessAutoDisposeAsyncNotifier<List<ProductsResponseDto>> {
  late final int size;

  FutureOr<List<ProductsResponseDto>> build({int size = 10});
}

/// See also [InfiniteProducts].
@ProviderFor(InfiniteProducts)
const infiniteProductsProvider = InfiniteProductsFamily();

/// See also [InfiniteProducts].
class InfiniteProductsFamily
    extends Family<AsyncValue<List<ProductsResponseDto>>> {
  /// See also [InfiniteProducts].
  const InfiniteProductsFamily();

  /// See also [InfiniteProducts].
  InfiniteProductsProvider call({int size = 10}) {
    return InfiniteProductsProvider(size: size);
  }

  @override
  InfiniteProductsProvider getProviderOverride(
    covariant InfiniteProductsProvider provider,
  ) {
    return call(size: provider.size);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'infiniteProductsProvider';
}

/// See also [InfiniteProducts].
class InfiniteProductsProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          InfiniteProducts,
          List<ProductsResponseDto>
        > {
  /// See also [InfiniteProducts].
  InfiniteProductsProvider({int size = 10})
    : this._internal(
        () => InfiniteProducts()..size = size,
        from: infiniteProductsProvider,
        name: r'infiniteProductsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$infiniteProductsHash,
        dependencies: InfiniteProductsFamily._dependencies,
        allTransitiveDependencies:
            InfiniteProductsFamily._allTransitiveDependencies,
        size: size,
      );

  InfiniteProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.size,
  }) : super.internal();

  final int size;

  @override
  FutureOr<List<ProductsResponseDto>> runNotifierBuild(
    covariant InfiniteProducts notifier,
  ) {
    return notifier.build(size: size);
  }

  @override
  Override overrideWith(InfiniteProducts Function() create) {
    return ProviderOverride(
      origin: this,
      override: InfiniteProductsProvider._internal(
        () => create()..size = size,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        size: size,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    InfiniteProducts,
    List<ProductsResponseDto>
  >
  createElement() {
    return _InfiniteProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is InfiniteProductsProvider && other.size == size;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, size.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin InfiniteProductsRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProductsResponseDto>> {
  /// The parameter `size` of this provider.
  int get size;
}

class _InfiniteProductsProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          InfiniteProducts,
          List<ProductsResponseDto>
        >
    with InfiniteProductsRef {
  _InfiniteProductsProviderElement(super.provider);

  @override
  int get size => (origin as InfiniteProductsProvider).size;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

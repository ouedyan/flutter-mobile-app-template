// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiServiceHash() => r'ebc99be2c6585841eb8321e681a6e2f99472a198';

/// An API service that handles authentication and exposes an [ApiClient].
///
/// Every API call coming from UI should watch/read this provider instead of
/// instantiating the [ApiClient] itself. When being watched, it will force any
/// data provider (provider that fetches data) to refetch when the
/// authentication state changes.
///
/// The API client is kept alive to follow dio's recommendation to use the same
/// client instance for the entire app.
///
/// Copied from [apiService].
@ProviderFor(apiService)
final apiServiceProvider = AutoDisposeProvider<ApiClient>.internal(
  apiService,
  name: r'apiServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$apiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiServiceRef = AutoDisposeProviderRef<ApiClient>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

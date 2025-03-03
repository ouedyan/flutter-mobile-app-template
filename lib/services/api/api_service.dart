import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'api_client.dart';
import 'mocked_api_client.dart';

part 'api_service.g.dart';

/// An API service that handles authentication and exposes an [ApiClient].
///
/// Every API call coming from UI should watch/read this provider instead of
/// instantiating the [ApiClient] itself. When being watched, it will force any
/// data provider (provider that fetches data) to refetch when the
/// authentication state changes.
///
/// The API client is kept alive to follow dio's recommendation to use the same
/// client instance for the entire app.
@riverpod
ApiClient apiService(Ref ref) {
  final ApiClient client;

  const mock = bool.fromEnvironment('MOCK_API', defaultValue: false);
  client = switch (mock) {
    true => MockedApiClient(),
    false => ApiClient(),
  };
  // Or for eg with token handling
  // client = switch (mock) {
  //   true => accessToken != null ? MockedApiClient.withToken(accessToken) : MockedApiClient(),
  //   false => accessToken != null ? ApiClient.withToken(accessToken) : ApiClient(),
  // };
  ref.keepAlive();

  return client;
}

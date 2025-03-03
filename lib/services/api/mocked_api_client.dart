import 'package:flutter_mobile_template/services/api/api_client.dart';

import '../../features/auth/data/auth_api_client.dart';
import '../../features/demo/data/demo_api_client.dart';
import '../../features/demo/data/mocked_demo_api_client.dart';

class MockedApiClient implements ApiClient {
  final Duration _delay;
  String? _accessToken;

  @override
  late final AuthApiClient auth;
  @override
  late final DemoApiClient demo;

  MockedApiClient({Duration? delay})
      : _delay = delay ?? const Duration(milliseconds: 500) {
    _initializeApiClients();
  }

  // Or for eg with [accessToken] set for authorization
  // MockedApiClient.withToken(String accessToken, {Duration? delay})
  //     : _delay = delay ?? const Duration(milliseconds: 500),
  //       _accessToken = accessToken {
  //   _initializeApiClients();
  // }

  void _initializeApiClients() {
    // auth = MockedAuthApiClient();
    demo = MockedDemoApiClient();
  }
}

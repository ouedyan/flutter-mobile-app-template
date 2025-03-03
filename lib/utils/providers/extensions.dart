import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Watch https://github.com/bamlab/riverpod_community_extensions for more

extension AutoDisposeRefUtils on Ref {
  void refreshTimeout(Duration duration) {
    final timer = Timer(duration, () => invalidateSelf());
    onDispose(() => timer.cancel());
    AppLifecycleListener();
  }

  /// Keeps the provider alive for [duration].
  /// See https://riverpod.dev/docs/essentials/auto_dispose#example-keeping-state-alive-for-a-specific-amount-of-time
  void cacheFor(Duration duration) {
    // Immediately prevent the state from getting destroyed.
    final link = keepAlive();
    // After duration has elapsed, we re-enable automatic disposal.
    final timer = Timer(duration, link.close);

    // Optional: when the provider is recomputed (such as with ref.watch),
    // we cancel the pending timer.
    onDispose(timer.cancel);
  }
}

import 'package:flutter/material.dart';

import '../network/no_network_widget.dart';

class MainBuild extends StatelessWidget {
  const MainBuild({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: child ?? const SizedBox.shrink(),
        ),
        const NoNetworkWidget()
      ],
    );
  }
}

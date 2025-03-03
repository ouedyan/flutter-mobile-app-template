import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main_bottom_navigation_bar.dart';
import 'root_scaffold.dart';

class MainRootScaffold extends StatelessWidget {
  const MainRootScaffold({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(context) {
    return RootScaffold<MainRootScaffold>(
      body: navigationShell,
      bottomNavigationBar: MainBottomNavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected:
            (index) => navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
      ),
      // appBar: eg common app bar
    );
  }
}

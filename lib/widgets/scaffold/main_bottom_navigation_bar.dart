import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../i18n/translations.g.dart';
import '../svg.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({super.key, this.selectedIndex = 0, this.onDestinationSelected});

  final int selectedIndex;
  final void Function(int)? onDestinationSelected;

  @override
  Widget build(context) {
    final t = Translations.of(context);

    return NavigationBar(
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: t.common.home,
        ),
        NavigationDestination(
          icon: Assets.icons.demo.Svg(matchTheme: true),
          label: t.common.demo,
        ),
      ],
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
    );
  }
}

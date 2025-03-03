import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A configuration class that defines how UI elements should be rendered at the root level
/// of a [RootScaffold].
///
/// This class is used to register page-specific UI elements (like drawers) that need
/// to be rendered at the root level for proper z-ordering and gesture handling.
/// When a [PageScaffold] needs to show elements like drawers, it creates an instance
/// of this class and registers it with its parent [RootScaffold].
///
/// The configuration is route-specific, meaning each route can have its own unique
/// configuration of root-level UI elements.
///
/// Example:
/// ```dart
/// final config = RootScaffoldConfig(
///   drawer: MyDrawer(),
///   drawerEnableOpenDragGesture: true,
/// );
/// ```
class RootScaffoldConfig {
  /// See [Scaffold.drawer].
  final Widget? drawer;

  /// See [Scaffold.onDrawerChanged].
  final DrawerCallback? onDrawerChanged;

  /// See [Scaffold.endDrawer].
  final Widget? endDrawer;

  /// See [Scaffold.onEndDrawerChanged].
  final DrawerCallback? onEndDrawerChanged;

  /// See [Scaffold.drawerScrimColor].
  final Color? drawerScrimColor;

  /// See [Scaffold.drawerDragStartBehavior].
  final DragStartBehavior drawerDragStartBehavior;

  /// See [Scaffold.drawerEdgeDragWidth].
  final double? drawerEdgeDragWidth;

  /// See [Scaffold.drawerEnableOpenDragGesture].
  final bool drawerEnableOpenDragGesture;

  /// See [Scaffold.endDrawerEnableOpenDragGesture].
  final bool endDrawerEnableOpenDragGesture;

  RootScaffoldConfig({
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
  });
}

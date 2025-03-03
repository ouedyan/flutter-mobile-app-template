import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'root_scaffold_config_provider.dart';

/// A root-level scaffold that can host shared UI elements and manage configurations
/// from child [PageScaffold]s.
///
/// The type parameter [T] is used to create a type-safe relationship between
/// [RootScaffold]s and [PageScaffold]s. This ensures that configurations are only
/// shared between scaffolds of the same type hierarchy.
///
/// This scaffold is typically used for:
/// * Creating a shell around a navigation section (e.g., bottom navigation)
/// * Hosting shared UI elements across multiple pages
/// * Managing proper z-ordering of UI elements like drawers
///
/// Example:
/// ```dart
/// class MainRootScaffold extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return RootScaffold<MainRootScaffold>(
///       body: navigationShell,
///       bottomNavigationBar: BottomNavigationBar(...),
///     );
///   }
/// }
/// ```
///
/// Child pages can then use [PageScaffold<MainRootScaffold>] to automatically
/// delegate certain UI elements to this root scaffold.
class RootScaffold<T extends Widget> extends HookConsumerWidget {
  /// See [Scaffold.extendBody].
  final bool extendBody;

  /// See [Scaffold.extendBodyBehindAppBar].
  final bool extendBodyBehindAppBar;

  /// See [Scaffold.appBar].
  final PreferredSizeWidget? appBar;

  /// See [Scaffold.body].
  final Widget? body;

  /// See [Scaffold.floatingActionButton].
  final Widget? floatingActionButton;

  /// See [Scaffold.floatingActionButtonLocation].
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  /// See [Scaffold.floatingActionButtonAnimator].
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;

  /// See [Scaffold.persistentFooterButtons].
  final List<Widget>? persistentFooterButtons;

  /// See [Scaffold.persistentFooterAlignment].
  final AlignmentDirectional persistentFooterAlignment;

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

  /// See [Scaffold.backgroundColor].
  final Color? backgroundColor;

  /// See [Scaffold.bottomNavigationBar].
  final Widget? bottomNavigationBar;

  /// See [Scaffold.bottomSheet].
  final Widget? bottomSheet;

  /// See [Scaffold.resizeToAvoidBottomInset].
  final bool? resizeToAvoidBottomInset;

  /// See [Scaffold.primary].
  final bool primary;

  /// See [Scaffold.drawerDragStartBehavior].
  final DragStartBehavior drawerDragStartBehavior;

  /// See [Scaffold.drawerEdgeDragWidth].
  final double? drawerEdgeDragWidth;

  /// See [Scaffold.drawerEnableOpenDragGesture].
  final bool drawerEnableOpenDragGesture;

  /// See [Scaffold.endDrawerEnableOpenDragGesture].
  final bool endDrawerEnableOpenDragGesture;

  /// See [Scaffold.restorationId].
  final String? restorationId;

  const RootScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.drawer,
    this.onDrawerChanged,
    this.endDrawer,
    this.onEndDrawerChanged,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor,
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.restorationId,
  }) : assert(
         T != Widget,
         'RootScaffold must be used with a specific Widget type (e.g., RootScaffold<MainRootScaffold>). '
         'Using RootScaffold without generic type is not allowed.',
       );

  @override
  Widget build(context, ref) {
    final scaffoldKeyRef = useRef(GlobalKey<ScaffoldState>());
    final rootScaffoldProvider = useMemoized(() => createRootScaffoldConfigProvider<T>(scaffoldKeyRef.value));

    final config = ref.watch(rootScaffoldProvider);

    return Scaffold(
      key: scaffoldKeyRef.value,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      persistentFooterAlignment: persistentFooterAlignment,
      drawer: config?.drawer ?? drawer,
      onDrawerChanged: config?.onDrawerChanged ?? onDrawerChanged,
      endDrawer: config?.endDrawer ?? endDrawer,
      onEndDrawerChanged: config?.onEndDrawerChanged ?? onEndDrawerChanged,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      primary: primary,
      drawerDragStartBehavior: config?.drawerDragStartBehavior ?? drawerDragStartBehavior,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      drawerScrimColor: config?.drawerScrimColor ?? drawerScrimColor,
      drawerEdgeDragWidth: config?.drawerEdgeDragWidth ?? drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: config?.drawerEnableOpenDragGesture ?? drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: config?.endDrawerEnableOpenDragGesture ?? endDrawerEnableOpenDragGesture,
      restorationId: restorationId,
    );
  }
}

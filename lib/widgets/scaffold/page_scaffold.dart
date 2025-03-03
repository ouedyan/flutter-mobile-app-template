import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'root_scaffold_config.dart';
import 'root_scaffold_config_provider.dart';

/// A page-level scaffold that can work both independently or in conjunction with a
/// parent [RootScaffold].
///
/// The type parameter [R] specifies which type of [RootScaffold] this page should
/// integrate with. When a matching [RootScaffold] is found in the widget tree,
/// certain UI elements (like drawers) will be automatically delegated to the root
/// level for proper z-ordering and gesture handling.
///
/// Key features:
/// * Automatic SafeArea wrapping with [useSafeArea]
/// * Proper text field focus behavior
/// * Automatic delegation of UI elements to parent [RootScaffold]s
/// * Works standalone when no matching [RootScaffold] is found
///
/// Example with root scaffold:
/// ```dart
/// PageScaffold<MainRootScaffold>(
///   appBar: AppBar(title: Text('My Page')),
///   drawer: MyDrawer(), // Will be rendered at root level
///   body: PageContent(),
/// )
/// ```
///
/// Example standalone:
/// ```dart
/// PageScaffold(
///   appBar: AppBar(title: Text('My Page')),
///   drawer: MyDrawer(), // Will be rendered normally
///   body: PageContent(),
///   useSafeArea: true,
/// )
/// ```
class PageScaffold<R extends Widget> extends Scaffold {
  final scaffoldConfigProvider = getRootScaffoldConfigProvider<R>();
  final rootScaffold = getRootScaffoldKey<R>()?.currentState;

  /// Whether to wrap the body with SafeArea.
  final bool useSafeArea;

  final bool _drawerEnableOpenDragGesture;
  final bool _endDrawerEnableOpenDragGesture;
  final Widget? _drawer;
  final DrawerCallback? _onDrawerChanged;
  final Widget? _endDrawer;
  final DrawerCallback? _onEndDrawerChanged;
  final Color? _drawerScrimColor;
  final DragStartBehavior _drawerDragStartBehavior;
  final double? _drawerEdgeDragWidth;

  static bool _hasRootScaffold<T extends Widget>() {
    return getRootScaffoldKey<T>()?.currentState != null;
  }

  PageScaffold({
    super.key,
    super.extendBody = false,
    super.extendBodyBehindAppBar = false,
    super.appBar,
    Widget? body,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.floatingActionButtonAnimator,
    super.persistentFooterButtons,
    super.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    Widget? drawer,
    DrawerCallback? onDrawerChanged,
    Widget? endDrawer,
    DrawerCallback? onEndDrawerChanged,
    Color? drawerScrimColor,
    super.backgroundColor,
    super.bottomNavigationBar,
    super.bottomSheet,
    super.resizeToAvoidBottomInset,
    super.primary = true,
    DragStartBehavior drawerDragStartBehavior = DragStartBehavior.start,
    double? drawerEdgeDragWidth,
    bool drawerEnableOpenDragGesture = true,
    bool endDrawerEnableOpenDragGesture = true,
    super.restorationId,
    this.useSafeArea = true,
  }) : _drawer = drawer,
       _onDrawerChanged = onDrawerChanged,
       _endDrawer = endDrawer,
       _onEndDrawerChanged = onEndDrawerChanged,
       _drawerScrimColor = drawerScrimColor,
       _drawerDragStartBehavior = drawerDragStartBehavior,
       _drawerEdgeDragWidth = drawerEdgeDragWidth,
       _drawerEnableOpenDragGesture = drawerEnableOpenDragGesture,
       _endDrawerEnableOpenDragGesture = endDrawerEnableOpenDragGesture,
       super(
         body:
             body != null
                 ? useSafeArea
                     ? SafeArea(child: body)
                     : body
                 : null,
         drawer: !_hasRootScaffold<R>() ? drawer : null,
         onDrawerChanged: !_hasRootScaffold<R>() ? onDrawerChanged : null,
         endDrawer: !_hasRootScaffold<R>() ? endDrawer : null,
         onEndDrawerChanged: !_hasRootScaffold<R>() ? onEndDrawerChanged : null,
         drawerScrimColor: !_hasRootScaffold<R>() ? drawerScrimColor : null,
         drawerDragStartBehavior: !_hasRootScaffold<R>() ? drawerDragStartBehavior : DragStartBehavior.start,
         drawerEdgeDragWidth: !_hasRootScaffold<R>() ? drawerEdgeDragWidth : null,
         drawerEnableOpenDragGesture: !_hasRootScaffold<R>() ? drawerEnableOpenDragGesture : false,
         endDrawerEnableOpenDragGesture: !_hasRootScaffold<R>() ? endDrawerEnableOpenDragGesture : false,
       );

  @override
  ScaffoldState createState() => PageScaffoldState<R>();
}

class PageScaffoldState<R extends Widget> extends ScaffoldState {
  late String routePath;
  late ProviderContainer _providerContainer;

  PageScaffold<R> get scaffoldWidget => (widget as PageScaffold<R>);

  RootScaffoldConfigProvider<R>? get scaffoldConfigProvider => scaffoldWidget.scaffoldConfigProvider;

  ScaffoldState? get rootScaffold => scaffoldWidget.rootScaffold;

  bool get hasRootScaffold => rootScaffold != null;

  RootScaffoldConfig? get rootScaffoldConfig {
    return scaffoldConfigProvider != null
        ? ProviderScope.containerOf(context, listen: false).read(scaffoldConfigProvider!)
        : null;
  }

  RootScaffoldConfigState<R>? get rootScaffoldConfigNotifier {
    return scaffoldConfigProvider != null
        ? ProviderScope.containerOf(context, listen: false).read(scaffoldConfigProvider!.notifier)
        : null;
  }

  @override
  bool get hasDrawer {
    final hasDrawer = scaffoldWidget._drawer != null;
    return hasDrawer;
  }

  @override
  bool get hasEndDrawer {
    final hasEndDrawer = scaffoldWidget._endDrawer != null;
    return hasEndDrawer;
  }

  @override
  void openDrawer() {
    hasRootScaffold ? rootScaffold!.openDrawer() : super.openDrawer();
  }

  @override
  void openEndDrawer() {
    hasRootScaffold ? rootScaffold!.openEndDrawer() : super.openEndDrawer();
  }

  @override
  void closeDrawer() {
    hasRootScaffold ? rootScaffold!.closeDrawer() : super.closeDrawer();
  }

  @override
  void closeEndDrawer() {
    hasRootScaffold ? rootScaffold!.closeEndDrawer() : super.closeEndDrawer();
  }

  void updateRootScaffold() {
    RootScaffoldConfig? config;

    if (scaffoldWidget._drawer != null || scaffoldWidget._endDrawer != null) {
      config = RootScaffoldConfig(
        drawer: scaffoldWidget._drawer,
        onDrawerChanged: scaffoldWidget._onDrawerChanged,
        endDrawer: scaffoldWidget._endDrawer,
        onEndDrawerChanged: scaffoldWidget._onEndDrawerChanged,
        drawerScrimColor: scaffoldWidget._drawerScrimColor,
        drawerDragStartBehavior: scaffoldWidget._drawerDragStartBehavior,
        drawerEdgeDragWidth: scaffoldWidget._drawerEdgeDragWidth,
        drawerEnableOpenDragGesture: scaffoldWidget._drawerEnableOpenDragGesture,
        endDrawerEnableOpenDragGesture: scaffoldWidget._endDrawerEnableOpenDragGesture,
      );
    }

    if (config != null) {
      print("Registering config for route: $routePath");
      rootScaffoldConfigNotifier!.registerConfig(routePath, config);
    } else {
      rootScaffoldConfigNotifier!.unregisterConfig(routePath);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _providerContainer = ProviderScope.containerOf(context, listen: false);

    final routerState = GoRouterState.of(context);
    routePath = routerState.fullPath!;

    if (hasRootScaffold) updateRootScaffold();
  }

  @override
  void didUpdateWidget(PageScaffold<R> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (hasRootScaffold) {
      if (oldWidget._drawer != scaffoldWidget._drawer ||
          oldWidget._onDrawerChanged != scaffoldWidget._onDrawerChanged ||
          oldWidget._endDrawer != scaffoldWidget._endDrawer ||
          oldWidget._onEndDrawerChanged != scaffoldWidget._onEndDrawerChanged ||
          oldWidget._drawerScrimColor != scaffoldWidget._drawerScrimColor ||
          oldWidget._drawerDragStartBehavior != scaffoldWidget._drawerDragStartBehavior ||
          oldWidget._drawerEdgeDragWidth != scaffoldWidget._drawerEdgeDragWidth ||
          oldWidget._drawerEnableOpenDragGesture != scaffoldWidget._drawerEnableOpenDragGesture ||
          oldWidget._endDrawerEnableOpenDragGesture != scaffoldWidget._endDrawerEnableOpenDragGesture) {
        updateRootScaffold();
      }
    }
  }

  @override
  void dispose() {
    if (hasRootScaffold) _providerContainer.read(scaffoldConfigProvider!.notifier).unregisterConfig(routePath);
    super.dispose();
  }

  @protected
  @override
  Widget build(context) {
    return UnfocusEditableTextsOnTapOutside(child: super.build(context));
  }
}

class UnfocusEditableTextsOnTapOutside extends StatelessWidget {
  final Widget child;

  const UnfocusEditableTextsOnTapOutside({super.key, required this.child});

  @override
  Widget build(context) {
    // By default, tapping outside editable text fields will not unfocus them as a result of mobile
    // application touch events (which does not include mouse clicks), to conform
    // with the platform conventions.
    // See https://api.flutter.dev/flutter/material/TextField/onTapOutside.html
    return Actions(
      actions: {
        EditableTextTapOutsideIntent: Action<EditableTextTapOutsideIntent>.overridable(
          context: context,
          defaultAction: _EditableTextTapOutsideAction(),
        ),
      },
      child: child,
    );
  }
}

// See default implementation at https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/widgets/editable_text.dart
class _EditableTextTapOutsideAction extends ContextAction<EditableTextTapOutsideIntent> {
  _EditableTextTapOutsideAction();

  @override
  void invoke(EditableTextTapOutsideIntent intent, [BuildContext? context]) {
    intent.focusNode.unfocus();
  }
}

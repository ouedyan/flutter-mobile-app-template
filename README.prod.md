# {Project Name}

A cross-platform Flutter application built with modern tooling and best practices. For detailed documentation about initial configuration, features and architecture, visit the [template repository](https://github.com/ouedyan/flutter-mobile-app-template).

## Project Structure

```
📂 assets
   📂 icons                                   # Vector and raster icon assets
   📂 images                                  # Image assets
   📂 i18n
      📂 {locale}                             # Localized resources by language
         📄 {namespace}.json                  # Translation resources by feature

📂 lib
   📂 constants                               # Application-wide constants

   📂 features                                # Feature modules
      📂 {feature}                            # e.g., auth, home, settings
         📂 data
            📂 models                         # Feature-specific data models
            📄 {feature}_api_client.dart      # API endpoints for the feature
            📄 {entity}_provider.dart         # State providers for the feature
         📂 screens                           # UI screens within the feature
            📄 {screen_name}_screen.dart
         📂 widgets                           # Feature-specific UI components
            📄 {widget_name}.dart

   📂 gen                                     # Generated files (assets, etc.)

   📂 i18n                                    # Internationalization
      📄 locale_provider.dart                 # Locale state management

   📂 services                                # Core application services
      📂 api                                  # API infrastructure
         📄 api_client.dart                   # Base API client
         📄 api_service.dart                  # API service with error handling
         📄 mocked_api_client.dart            # Testing helpers
      📂 navigation                           # Routing system
         📄 router.dart                       # Application router configuration
         📄 route_page.dart                   # Custom route page implementation
         📄 pop_notifier.dart                 # Navigation state refresh fixes
      📂 storage                              # Data persistence
         📄 secure_storage.dart               # Encrypted storage service
         📄 prefs.dart                        # Key-value storage service

   📂 theme                                   # App theming
      📄 app_theme.dart                       # Theme definitions

   📂 utils                                   # Utility functions and extensions
      📂 data
         📂 hooks                             # Custom hook implementations
            📄 use_query.dart                 # React-Query inspired data fetching
            📄 use_async_task.dart            # Async operation management
      📂 forms                                # Form helpers
      📂 providers                            # Provider utilities
         📄 extensions.dart                   # Provider extension methods
      📂 router                               # Router utilities
         📄 redirects.dart                    # Navigation guards and redirects
      📂 strings                              # String manipulation

   📂 widgets                                 # Shared UI components
      📂 scaffold                             # Advanced scaffolding system
         📄 root_scaffold.dart                # Base root scaffold
         📄 page_scaffold.dart                # Smart page scaffold
         📄 root_scaffold_config.dart         # Configuration system
      📄 alerts.dart                          # Alert dialog system
      📄 snackbars.dart                       # Notification system
      📄 svg.dart                             # SVG rendering utilities

   📄 main.dart                               # Application entry point
```

## Useful Commands

### Code Generation

Generate code for all code-generating packages:

```bash
dart run build_runner build
```

Overwrite conflicting outputs:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Watch for changes and regenerate:

```bash
dart run build_runner watch
```

### Internationalization

Generate translation files:

```bash
dart run slang
```

Analyze translations:

```bash
dart run slang analyze
```

### App Configuration

Generate launcher icons:

```bash
dart run flutter_launcher_icons
```

Generate splash screens:

```bash
dart run flutter_native_splash:create
```

Restore default splash screen:

```bash
dart run flutter_native_splash:remove
```

## Main Tech Stack's Useful Resources

### Flutter & Dart
- [Flutter Documentation](https://docs.flutter.dev) - Official Flutter docs
- [Dart Documentation](https://dart.dev/guides) - Official Dart guides

### State Management
- [Riverpod Documentation](https://riverpod.dev) - Official Riverpod docs
- [Flutter Hooks](https://pub.dev/packages/flutter_hooks) - Reuse stateful logic

### Architecture
- [GoRouter](https://pub.dev/packages/go_router) - Declarative routing
- [Dio](https://pub.dev/packages/dio) - HTTP client documentation

### Internationalization
- [Slang](https://pub.dev/packages/slang) - Type-safe internationalization

### UI/UX
- [Flutter ScreenUtil](https://pub.dev/packages/flutter_screenutil) - Responsive design
- [Google Fonts](https://pub.dev/packages/google_fonts) - Typography
- [Flutter SVG](https://pub.dev/packages/flutter_svg) - SVG rendering
- [Reactive Forms](https://pub.dev/packages/reactive_forms) - Form management
- [Flutter Animate](https://pub.dev/packages/flutter_animate) - Animation library

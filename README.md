# Flutter Mobile Template

![Flutter Version](https://img.shields.io/badge/Flutter-3.29+-blue.svg)
![Dart Version](https://img.shields.io/badge/Dart-3.7+-blue.svg)

A production-ready Flutter starter template designed for building scalable mobile applications with industry best practices and a comprehensive toolset.

## Why This Template?

- 🚀 **Production-Ready**: Built with scalability and maintainability in mind
- 📱 **Cross-Platform**: Optimized for both Android and iOS platforms
- 🔒 **Type-Safe**: Leverages Dart's strong typing with code generation
- 🔄 **State Management**: Integrated Hooks Riverpod for efficient reactive programming
- 🌐 **Networking**: Preconfigured Dio API clients with proper error handling
- 🌍 **Internationalization**: Type-safe i18n solution with Slang
- 🧪 **Testable**: Structure designed for easy unit and widget testing
- 🔧 **Developer Experience**: Extensive tooling and utilities included

## Key Features

### State Management & Dependency Injection
- **Hooks Riverpod**: Complete integration with code generation support via Riverpod Generator
- **Flutter Hooks**: For reusable stateful logic
- **Custom Query System**: React-Query inspired hooks system with useQuery, useInfiniteQuery, useAsyncTask...
- **Provider Observers**: Built-in debugging tools for state changes

### Routing & Navigation
- **Go Router**: Type-safe routing with deep linking support
- **Custom Route Extensions**:
  - Fixes for common GoRouter issues
  - Enhanced RoutePage implementation with consistent navigation behavior
- **Router State Provider**: For reactive routing state access

### API & Networking
- **Dio**: Configured HTTP client with interceptors
- **Repository Pattern**: Clean data layer organization
- **Centralized Error Handling**: Via custom ApiService implementation
- **Mock API Clients**: Testing-friendly API infrastructure with repository pattern

### Data Persistence
- **Flutter Secure Storage**: Encrypted storage for sensitive data
- **Shared Preferences**: Simple key-value storage wrapper
- **Type-safe Storage Access**: Strongly typed providers for storage values

### UI/UX Components
- **Advanced Scaffolding System**:
  - Root scaffold with config provider for separation of concerns
  - Page scaffold with widget delegation and useful common fixes and features
- **Responsive Design**: Flutter ScreenUtil integration for adaptive interfaces
- **Theme System**: Type-safe theme with Theme Tailor
- **SVG Support**: Flutter SVG for vector graphics rendering
- **Form Management**: Reactive Forms with validation
- **Common UI Components**:
  - Dialog and alert system with standardized API
  - Snackbar and toast messages with consistent styling

### Internationalization
- **Slang**: For strongly-typed translations
- **Locale Management**: Dynamic locale switching with persistence

### Developer Tooling
- **Custom Lint Rules**: Via Flutter Lints, Custom Lint, and Riverpod Lint
- **Conventional Commits**: Enforced via Commitlint CLI
- **Git Hooks**: Pre-commit and pre-push checks via Husky
- **Flutter Gen**: Asset code generation for type-safe asset access

### App Configuration
- **Launch Icons**: Flutter Launcher Icons for customizing app icons
- **Native Splash**: Flutter Native Splash for splash screen configuration
- **App Metadata**: Package name and app name management via Change App Package Name and Rename

## Getting Started

### Initial Project Configuration

1. Change the app name:

```bash
flutter pub run rename --appname "YourAppName"
```

2. Change the package name/bundle id:

```bash
flutter pub run change_app_package_name:main com.company.name && flutter pub run rename --bundleId com.company.name
```

3. Configure splash screen in `flutter_native_splash.yaml`:

```yaml
flutter_native_splash:
  # ...
  color: "#ffffff"
  background_image: "assets/background.png"
  image: assets/splash.png
  # ... other configurations
```

4. Generate splash screens:

```bash
dart run flutter_native_splash:create
```

5. Configure app icons in `flutter_launchers_icons.yaml`:

```yaml
flutter_icons:
  android: "launcher_icon"
  image_path: "assets/icons/launcher_icon.png"
  min_sdk_android: 21
  ios: true
  remove_alpha_ios: true
  # ... other configurations
```

6. Generate app icons:

```bash
dart run flutter_launcher_icons
```

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

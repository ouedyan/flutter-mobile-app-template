# Flutter Mobile App Project Template (flutter_bloc, autoroute, dio, json_serializable, easy_localization bot_toast, flutter_secure_storage(and helpers), flutter_screenutil, flutter_native_splash, flutter_launcher_icons and other generally used features and tools in production.)

This is a battery included [Flutter](https://flutter.dev/) project template. To the default setup have been added:

- [flutter_bloc](https://bloclibrary.dev/) - Predictable and Highly testable state management library for Dart.
- [go_router](https://pub.dev/packages/go_router) - Robust and customizable Flutter navigation package.
- [vexana](https://pub.dev/packages/vexana) - Popular and powerful Http client for Dart.
- [json_serializable](https://pub.dev/packages/json_serializable) - Generates to/from json serialization code for our data models.
- [easy_localization](https://pub.dev/packages/easy_localization) - Easy and Fast internationalization.
- [bot_toast](https://pub.dev/packages/bot_toast) - Feature-Rich Toast/alert/notification/popup library for Flutter.
- [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) - A Flutter plugin to store data in secure storage (encrypted, not in plain text like shared_preferences). Eg. for storing user credentials, tokens...
- [sizer](https://pub.dev/packages/sizer) - A package for adapting screen and font size.
- [flutter_svg](https://pub.dev/packages/flutter_svg) - For rendering SVG assets.
- Some tooling for project initial setup.
    - [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) - Generates iOS, Android, and Web-native code for customizing the native splash screen background color and splash image.
    - [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) - Fully flexible toolset for updating your Flutter app's launcher icons (Android and Ios).
    - [rename](https://pub.dev/packages/rename) - Change your flutter project's AppName and BundleId (IOS, Android, macOS and Web).
    - [change_app_package_name](https://pub.dev/packages/change_app_package_name) - Complementary to **rename** package, for changing app package name in Android and renaming correctly directories (which **rename** doesn't do).

## Project Config roadmap (Just Informative. Don't repeat these steps.)

All the necessary config and dependencies have already been set and ready for use but there is an explanation of each step if you want to know more about the pre-config or customize it.

Initialize the Flutter project, add all the necessary dependencies mentioned above in the **pubspec.yaml** configuration file and run `pub get`.

**pubspec.yaml**
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.5

  #Responsive
  sizer: ^2.0.15

  #Image
  flutter_svg: ^1.1.6

  #State Management
  provider: ^6.0.4
  flutter_bloc: ^8.1.1

  #JsonAnnotation
  json_annotation: ^4.7.0
  equatable: ^2.0.5

  #Network
  vexana: ^3.0.1

  #Locale Storage
  flutter_secure_storage: ^6.0.0

  #Navigation
  go_router: ^5.1.1

  #Localization
  intl: ^0.17.0
  easy_localization: ^3.0.1
  bot_toast: ^4.0.3

  #Native Splash Screen
  flutter_native_splash: ^2.2.13

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.1

  # Code generation
  build_runner: ^2.2.0
  auto_route_generator: ^5.0.3

  # Json serialization code generation
  json_serializable: ^6.3.1

  # Native Launcher Icons generator
  flutter_launcher_icons: ^0.10.0

  # Change app package name/bundle id and app name
  change_app_package_name: ^1.1.0
  rename: ^2.0.1
```

Change the app name to your own one.
```bash
flutter pub run rename --appname "YourAppName"
```

Change the package name/bundle id to your own one.
```bash
flutter pub run change_app_package_name:main com.company.name &&
flutter pub run rename --bundleId com.company.name
```

Add **flutter_native_splash.yaml** config file to the project root directory.
_(See the concerned for more information)_
```yaml
flutter_native_splash:
  # ...
  color: "#ffffff"
  background_image: "assets/background.png"
  image: assets/splash.png
  # ...
```

Generate the splash screens after you have added your own configuration.
```bash
flutter pub run flutter_native_splash:create
```

Add **flutter_launchers_icons.yaml** config file to the project root directory.
_(See the concerned for more information)_
```yaml
flutter_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icons/launcher_icon.png"
  # Icons with alpha channel are not allowed in the Apple App Store.
  remove_alpha_ios: true
  # ...
```

Generate the launcher icons after you have added your own configuration.
```bash
flutter pub run flutter_launcher_icons:main
```


The android minSdKVersion is set to **Android API level 21** to comply to modern libraries requirements support. Eg. flutter_secure_storage (requires Android API level 18).

**android/app/build.gradle**
```groovy
android {
//...
  defaultConfig {
    //...
    minSdkVersion 21
    targetSdkVersion flutter.targetSdkVersion
    versionCode flutterVersionCode.toInteger()
    versionName flutterVersionName
  }
//...
}
```



## Scripts

Change package name/bundle id
```bash
flutter pub run change_app_package_name:main com.new.package.name && flutter pub run rename --bundleId com.new.package.name
```

Change App Name
```bash
flutter pub run rename --appname "NewAppName"
```

Run build_runner to generate/regenerate code from code generating packages (autoroute, easy_localization, json_serializable, etc.)
```bash
flutter pub run build_runner build
```
Generate while overriding old outputs
```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```
Watch and regenerate after each change
```bash
flutter pub run build_runner watch
```

Generate easy_localization translation string keys for usage in code
```bash
flutter pub run easy_localization:generate  -O lib/core/ -f keys -o locale_keys.g.dart --source-dir assets/translations
```

Generate native launcher icons from config.
```bash
flutter pub run flutter_launcher_icons:main
```

Generate native splash screens from config
```bash
flutter pub run flutter_native_splash:create
```

## Project directory structure

Main folders structure

```
📂 assets
   📂 icons
   📂 images
   📂 translations
      📄 en.json
      ...📄 {locale}.json
      
📂 lib
   📂 core   
    📂 base
      📂 bloc
         📂 auth
            📄 {auth_bloc}.dart
            📄 {auth_event}.dart
            📄 {auth_state}.dart
         📄 app_bloc_observer.dart
      📂 functions
         📄 base_functions.dart
      📂 model
      📂 service
      📂 state
      📂 view
    📂 components
       📂 button
       📂 text
       📂 textFormField
    📂 constants
       📂 app
            📄 app_constants.dart
       📂 enums
            📄 api_enums.dart
    📂 extensions
            📄 color_extensions.dart
            📄 context_extensions.dart
            📄 iterable_extensions.dart
            📄 network_extensions.dart
            📄 num_extensions.dart
            📄 string_extensions.dart
    📂 init
       📂 language
       📂 local_storage
            📄 local_storage_manager.dart
       📂 network
            📄 vexana_manager.dart
       📂 routes
            📄 routes.dart
       📂 theme
            📄 colors.dart
    📄 dependency_injection.dart
    📄 locale_keys.g.dart
   📂 view
      📂 auth
      📂 home  
        📂 bloc
            📄 {home_bloc}.dart
            📄 {home_event}.dart
            📄 {home_state}.dart
        📂 model
        📂 service
            📄 vexana_manager.dart
        📂 widgets
        📄 home_view.dart 
   📄 main.dart
   
📂 test

📄 flutter_launcher_icons.yaml

📄 flutter_native_splash.yaml

📄 pubspec.yaml

```

## Project tech stack useful resources

### Flutter
- [Flutter](https://flutter.dev) - Flutter framework official website.
- [Flutter Docs](https://docs.flutter.dev) - Flutter official documentation.

### Dart
- [Dart](https://dart.dev) - Dart language official website.
- [Dart Docs](https://dart.dev/guides) - Dart official documentation.

import 'dart:io';

import 'package:yaml/yaml.dart';

void main() {
  final file = File('pubspec.yaml');
  final content = file.readAsStringSync();
  final yaml = loadYaml(content);
  final rangedDeps = <String>[];

  void checkVersions(Map<dynamic, dynamic>? deps) {
    if (deps == null) return;

    deps.forEach((package, version) {
      if (version is String && version.startsWith('^')) {
        rangedDeps.add('$package: $version');
      }
    });
  }

  checkVersions(yaml['dependencies'] as Map?);
  checkVersions(yaml['dev_dependencies'] as Map?);

  if (rangedDeps.isNotEmpty) {
    print('\x1B[31mError: Ranged versions found in pubspec.yaml\x1B[0m');
    print('\nRanged versions (starting with ^) allow automatic updates to newer versions.');
    print('This can lead to inconsistent builds. Please use exact versions instead.');
    print('\nExample:');
    print('  Instead of: package: ^1.2.3  (allows updates to 1.x.x)');
    print('  Use:        package: 1.2.3   (locks to exact version)\n');
    print('Dependencies to fix:');
    for (var dep in rangedDeps) {
      print('  - $dep');
    }
    exit(1);
  }
}

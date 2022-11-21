import '../constants/enums/api_enums.dart';

extension NetworkExtensions on NetworkEnums {
  String get key {
    switch (this) {
      case NetworkEnums.example:
        return "${NetworkBaseEnums.template.name}/zalisoft";
    }
  }
}

enum NetworkBaseEnums { template }

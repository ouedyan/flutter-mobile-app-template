extension StringUtils on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  String ifIsNullOrEmpty(String fallback) => isNullOrEmpty ? fallback : this!;
}

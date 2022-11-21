extension ImagePath on String {
  String get toSvg => "assets/icons/svg_$this.svg";

  String get toPng => "assets/images/ig_$this.png";

  String get toJpg => "assets/images/ig_$this.jpg";

  String get toPngIc => "assets/icons/ic_$this.png";

  String get toJpegIc => "assets/icons/ic_$this.jpg";
}

extension StringValidatorExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  bool get isNotNullOrNoEmpty => this != null && this!.isNotEmpty;
}

extension FormValidate on String {
  String? get emailValidate =>
      contains("@") ? null : "Please enter a valid email.";
}

extension StringExtensions on String {
  String getFirstWord() {
    List<String> wordList = split("");

    if (wordList.isNotEmpty) {
      return wordList[0];
    } else {
      return ' ';
    }
  }
}

extension NumberParsing on String {
  int get parseInt => int.parse(this);

  int? get tryParseInt => int.tryParse(this);

  double get parseDouble => double.parse(this);

  double? get tryParseDouble => double.tryParse(this);
}

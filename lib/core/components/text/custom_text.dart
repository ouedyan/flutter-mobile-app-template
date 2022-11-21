import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final int? maxLines;

  const CustomText(this.text,
      {Key? key, this.textStyle, this.textAlign, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: GoogleFonts.inter(textStyle: textStyle),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}

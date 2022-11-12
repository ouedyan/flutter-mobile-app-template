import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/app/app_constants.dart';

Widget platformIndicator() {
  return Center(
    child: Platform.isIOS
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator(),
  );
}

Widget platformBackButton({
  required VoidCallback onPressed,
  AlignmentGeometry alignment = Alignment.topLeft,
  Color? color = AppConstants.black,
}) {
  return Align(
    alignment: alignment,
    child: Platform.isIOS
        ? IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_back_ios,
              color: color,
            ))
        : IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.arrow_back,
              color: color,
            )),
  );
}

closePopup(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

String toShortString(String value, {int countCharacter = 8}) {
  return value.length > countCharacter
      ? "${value.substring(0, countCharacter)}..."
      : value;
}

String toShortDoubleNumber(double value) {
  String number = value.toString();
  return "${number.split(".").first}.${number.split(".")[1].substring(0, 2)}";
}

String convertStringDateYmm(String date) {
  return DateFormat.yMMMEd('tr_TR').format(DateTime.parse(date));
}

String convertStringDateTime(String date) {
  return DateFormat('dd/MM/yyyy hh:mm ').format(DateTime.parse(date));
}

String convertStringDateYmmm(String date) {
  return DateFormat.yMMMMEEEEd('tr_TR').format(DateTime.parse(date));
}

String convertStringDateYMMd(String date) {
  return DateFormat.yMMMd('tr_TR').format(DateTime.parse(date));
}

String convertStringDate4(String date) {
  return DateFormat.Hm('tr_TR').format(DateTime.parse(date));
}

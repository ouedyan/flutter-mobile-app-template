import 'package:flutter/material.dart';

Future<dynamic> buildGeneralDialog(BuildContext context) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return ScaleTransition(
        scale: Tween<double>(begin: .5, end: 1).animate(animation),
        child: const AlertDialog(),
      );
    },
  );
}

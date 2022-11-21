import 'package:flutter/material.dart';
import 'package:flutter_mobile_template/core/components/text/custom_text.dart';
import 'package:flutter_mobile_template/core/constants/app/app_constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(
          "Hello World!",
          textStyle: TextStyle(
            color: AppConstants.instance.black,
          ),
        ),
      ),
    );
  }
}

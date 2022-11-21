import 'package:flutter/material.dart';

import '../text/custom_text.dart';

class AnimatedText extends StatefulWidget {
  const AnimatedText(
    this.text, {
    super.key,
    this.textStyle,
  });

  final String text;
  final TextStyle? textStyle;

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      axis: Axis.horizontal,
      axisAlignment: -1,
      child: CustomText(
        widget.text,
        textStyle: widget.textStyle,
      ),
    );
  }
}

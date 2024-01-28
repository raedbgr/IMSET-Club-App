import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class MyAnimatedText extends StatelessWidget {
  final String text;

  const MyAnimatedText({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          text,
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
          ),
          speed: const Duration(milliseconds: 150),
        ),
      ],
      repeatForever: true,
      pause: const Duration(milliseconds: 1000),
    );
  }
}
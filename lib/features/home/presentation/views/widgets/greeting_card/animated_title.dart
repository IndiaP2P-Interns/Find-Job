import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({super.key});

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontSize: 18,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    );

    return AnimatedTextKit(
      repeatForever: true,
      animatedTexts: [
        TypewriterAnimatedText(
          "Find Your Dream Job Today",
          textStyle: style,
          speed: Duration(milliseconds: 70),
        ),
        TypewriterAnimatedText(
          "Apply to Jobs That Fit You",
          textStyle: style,
          speed: Duration(milliseconds: 70),
        ),
        TypewriterAnimatedText(
          "Grow Your Career With Confidence",
          textStyle: style,
          speed: Duration(milliseconds: 70),
        ),
      ],
    );
  }
}

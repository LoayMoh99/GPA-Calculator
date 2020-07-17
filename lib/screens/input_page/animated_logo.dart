import 'package:flutter/material.dart';

class AnimatedLogo extends StatelessWidget {
  final Animation<double> animation;
  final Size size;

  const AnimatedLogo({
    @required this.animation,
    @required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: animation,
      child: Container(
        width: size.width * 0.75,
        height: size.width * 0.75,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.05,
          horizontal: size.width * 0.05,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size.width * 0.75 / 2),
          child: Image.asset(
            'assets/images/gpaLogo.png',
          ),
        ),
      ),
    );
  }
}

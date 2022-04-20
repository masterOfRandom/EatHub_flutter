import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NopeScreen extends StatelessWidget {
  const NopeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Lottie.asset(
          'assets/images/heart_without_background.json',
          frameRate: FrameRate(60),
          repeat: false,
        ),
      ),
    );
  }
}

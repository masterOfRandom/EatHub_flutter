import 'package:flutter/material.dart';

// final durationMilliseconds = 1000;
// final translateDistance = 200;
// final movedAngle = 45 / 360;
// final startAngle = 0.0;
// final imageHeight = 100.0;
// final imageWidth = 100.0;
class RotateAnimationLoopImage extends StatefulWidget {
  final int durationMilliseconds;
  final double startPosition;
  final double endPosition;
  final double movedAngle;
  final double startAngle;
  final double imageHeight;
  final double imageWidth;

  const RotateAnimationLoopImage({
    Key? key,
    required this.durationMilliseconds,
    required this.startPosition,
    required this.endPosition,
    required this.movedAngle,
    required this.startAngle,
    required this.imageHeight,
    required this.imageWidth,
  }) : super(key: key);

  @override
  State<RotateAnimationLoopImage> createState() => _RotateAnimationStateLoop();
}

class _RotateAnimationStateLoop extends State<RotateAnimationLoopImage> {
  late double angle;
  late double position;
  late int milliseconds;
  late bool isMoved;

  void setIsMoved() {
    if (isMoved == true) {
      isMoved = false;
      position = widget.startPosition;
      angle = widget.startAngle;
      milliseconds = 200;
    } else {
      isMoved = true;
      position = widget.endPosition;
      angle = widget.movedAngle;
      milliseconds = widget.durationMilliseconds;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    angle = widget.startAngle;
    position = widget.startPosition;
    milliseconds = widget.durationMilliseconds;
    isMoved = false;
    Future.delayed(const Duration(milliseconds: 500), setIsMoved);
  }

  @override
  Widget build(BuildContext context) {
    final translateMatrix = Matrix4.identity()..translate(position);
    return AnimatedContainer(
      duration: Duration(milliseconds: milliseconds),
      transform: translateMatrix,
      curve: Curves.ease,
      child: AnimatedRotation(
        turns: angle,
        curve: Curves.ease,
        duration: Duration(milliseconds: milliseconds),
        onEnd: setIsMoved,
        child: Image.asset(
          'assets/images/hand.png',
          height: widget.imageHeight,
          width: widget.imageWidth,
        ),
      ),
    );
  }
}

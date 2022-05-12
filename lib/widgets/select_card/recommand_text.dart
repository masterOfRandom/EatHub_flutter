import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';

class RecommandText extends StatefulWidget {
  final String text;
  final bool isVisible;
  const RecommandText({Key? key, required this.text, required this.isVisible})
      : super(key: key);

  @override
  State<RecommandText> createState() => _RecommandTextState();
}

class _RecommandTextState extends State<RecommandText> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
      alignment: Alignment.center,
      height: widget.isVisible ? 58 : 0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundWhiteColor,
      ),
      child: Text(
        widget.text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

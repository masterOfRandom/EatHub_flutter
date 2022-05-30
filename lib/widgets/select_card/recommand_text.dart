import 'package:eathub/getx/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommandText extends StatefulWidget {
  final String text;
  final bool isVisible;
  const RecommandText({Key? key, required this.text, required this.isVisible})
      : super(key: key);

  @override
  State<RecommandText> createState() => _RecommandTextState();
}

class _RecommandTextState extends State<RecommandText> {
  final controller = Get.put(GController());

  @override
  Widget build(BuildContext context) {
    final height = controller.screenSize.value.height;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 10),
      height: widget.isVisible ? (height > 700 ? 56 : 36) : 0,
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: height > 700 ? 28 : 24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

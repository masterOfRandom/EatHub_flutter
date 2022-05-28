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
    final width = controller.screenSize.value.width;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10),
      height: widget.isVisible ? (width > 400 ? 100 : 80) : 0,
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: width > 400 ? 32 : 28,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

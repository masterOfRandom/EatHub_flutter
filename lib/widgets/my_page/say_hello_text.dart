import 'package:flutter/material.dart';

class SayHelloText extends StatefulWidget {
  final String? name;
  const SayHelloText({Key? key, required this.name}) : super(key: key);

  @override
  State<SayHelloText> createState() => _SayHelloTextState();
}

class _SayHelloTextState extends State<SayHelloText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      child: Text(
        '안녕하세요\n${widget.name}님',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

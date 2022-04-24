import 'package:flutter/material.dart';

class SayHelloText extends StatelessWidget {
  final String name;
  const SayHelloText({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      child: Text(
        '안녕하세요\n$name님',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

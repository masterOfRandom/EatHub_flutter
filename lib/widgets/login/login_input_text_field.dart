import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginInputTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String? errText;
  final bool isPassword;

  const LoginInputTextField({
    Key? key,
    this.focusNode,
    required this.controller,
    this.errText,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: this.isPassword,
      focusNode: focusNode,
      style: TextStyle(color: grayScaleGray2, fontSize: 14),
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 13),
        errorText: errText,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: primaryRedColor)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: grayScaleGray4),
        ),
      ),
    );
  }
}

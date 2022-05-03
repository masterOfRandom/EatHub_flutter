import 'package:eathub/presentation/table_pick_icons.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';

class LoginInputTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String? errText;
  final bool isPassword;
  final String? hintText;
  final bool isLogin;

  const LoginInputTextField({
    Key? key,
    this.focusNode,
    required this.controller,
    this.errText,
    this.hintText,
    this.isPassword = false,
    this.isLogin = false,
  }) : super(key: key);

  @override
  State<LoginInputTextField> createState() => _LoginInputTextFieldState();
}

class _LoginInputTextFieldState extends State<LoginInputTextField> {
  bool isNotEmpty = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        isNotEmpty = value.isNotEmpty;
        setState(() {});
      },
      obscureText: widget.isPassword,
      focusNode: widget.focusNode,
      style: const TextStyle(color: grayScaleGray2, fontSize: 14),
      keyboardType: TextInputType.emailAddress,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorMaxLines: 4,
        suffixIcon: !widget.isPassword || widget.isLogin
            ? (isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      widget.controller.clear();
                      isNotEmpty = false;
                      setState(() {});
                    },
                    child: const Icon(
                      TablePick.cancel,
                      color: grayScaleGray4,
                    ))
                : null)
            : widget.errText == null && isNotEmpty
                ? const Icon(
                    TablePick.check_circle,
                    color: secondaryPinkColor,
                  )
                : widget.errText == null
                    ? null
                    : const Icon(
                        TablePick.error,
                        color: primaryRedColor,
                      ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
        errorText: widget.errText,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: grayScaleGray4),
        ),
      ),
    );
  }
}

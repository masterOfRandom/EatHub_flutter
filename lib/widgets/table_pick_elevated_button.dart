import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';

class TablePickElevatedButton extends StatelessWidget {
  final VoidCallback? callback;
  final bool isLoading;
  final String text;
  const TablePickElevatedButton(
      {Key? key, this.callback, required this.isLoading, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryRedColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const CircularProgressIndicator(color: backgroundWhiteColor))
        : GestureDetector(
            onTap: callback,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryRedColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: backgroundLightPinkColor),
              ),
            ),
          );
  }
}

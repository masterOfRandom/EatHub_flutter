import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final VoidCallback? callback;
  final bool isLoading;
  const NextButton({Key? key, this.callback, required this.isLoading})
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
            child: const CircularProgressIndicator(color: primaryRedColor))
        : GestureDetector(
            onTap: callback,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: primaryRedColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                '다음',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: backgroundLightPinkColor),
              ),
            ),
          );
  }
}

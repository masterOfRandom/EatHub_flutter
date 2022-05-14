import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';

class TablePickDeactivatedButton extends StatelessWidget {
  final VoidCallback? callback;
  final bool isLoading;
  final String text;
  const TablePickDeactivatedButton(
      {Key? key, this.callback, required this.isLoading, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundLightPinkColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const CircularProgressIndicator(color: backgroundWhiteColor))
        : GestureDetector(
            onTap: callback,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: backgroundLightPinkColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: grayScaleGray5),
              ),
              child: Text(
                text,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: grayScaleGray5),
              ),
            ),
          );
  }
}

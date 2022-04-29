import 'package:carousel_slider/carousel_controller.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';

class OnboardStandardForm extends StatelessWidget {
  final Widget imageWidget;
  final Widget title;
  final String descript;
  final dynamic Function() callback;
  final String buttonText;

  const OnboardStandardForm({
    Key? key,
    required this.imageWidget,
    required this.title,
    required this.descript,
    required this.callback,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(top: 24),
          color: onboardingPinkColor,
          alignment: Alignment.center,
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 2,
          child: imageWidget,
        ),
        Container(
          padding: const EdgeInsets.only(left: 32, top: 52),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title,
              SizedBox(height: 28),
              Text(
                descript,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        Expanded(child: Container()),
        Container(
          padding: EdgeInsets.only(right: 8),
          alignment: Alignment.centerRight,
          child: TextButton(
            child: Text(
              buttonText,
              style: TextStyle(
                  color: primaryRedColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 20),
            ),
            onPressed: callback,
          ),
        ),
      ],
    );
  }
}

import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';

class FoodNameContainer extends StatelessWidget {
  final String foodName;
  const FoodNameContainer({Key? key, required this.foodName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundWhiteColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            '내 근처의 ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '$foodName집',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

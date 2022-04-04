import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_style.dart';
import 'package:flutter/material.dart';

class BriefDescription extends StatelessWidget {
  final String name;
  final String address;
  final String menu;
  final double rating;

  const BriefDescription({
    Key? key,
    required this.name,
    required this.address,
    required this.menu,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // 여기는 고쳐야 함.
      height: 160,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: cardRadius),
        color: primaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                  maxLines: 1,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Color(0xFFFFF38B),
                  ),
                  // Image.asset(
                  //   'assets/mini_star.png',
                  //   height: 18,
                  //   width: 18,
                  // ),
                  Text(
                    '${(rating * 10).round() / 10}',
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: descriptionFontColor,
                      fontSize: 20,
                    ),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            address,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: descriptionFontColor,
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          Text(
            menu,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: descriptionFontColor,
            ),
            maxLines: 1,
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_style.dart';
import 'package:flutter/material.dart';

class BriefDescription extends StatelessWidget {
  final String name;
  final List keyword;

  const BriefDescription({
    Key? key,
    required this.name,
    required this.keyword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // 여기는 고쳐야 함.
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: cardRadius),
        color: backgroundWhiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
            maxLines: 1,
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: keyword.map((e) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: backgroundGrayColor),
                ),
                child: Text(
                  e,
                  style: TextStyle(color: primaryRedColor, fontSize: 18),
                ),
              );
            }).toList(),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

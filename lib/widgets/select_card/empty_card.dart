import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundWhiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(),
            flex: 1,
          ),
          Expanded(
            child: Lottie.asset('assets/lotties/empty_card.json'),
            flex: 8,
          ),
          const SizedBox(height: 48),
          const Text(
            '총 1000개의 메뉴 카드를\n모두 보셨네요!\n카드 업데이트를 기다려주세요',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Flexible(
            child: Container(),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

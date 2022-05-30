import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EmptyCard extends StatefulWidget {
  const EmptyCard({Key? key}) : super(key: key);

  @override
  State<EmptyCard> createState() => _EmptyCardState();
}

class _EmptyCardState extends State<EmptyCard> {
  final controller = Get.put(GController());
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
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: 8,
            child: Lottie.asset('assets/lotties/empty_card.json'),
          ),
          const SizedBox(height: 48),
          Obx(() {
            return Text(
              '총 ${controller.randomIndex.value.foodsLength}개의 메뉴 카드를\n모두 보셨네요!\n카드 업데이트를 기다려주세요',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            );
          }),
          Flexible(
            flex: 1,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCheckedCard extends StatefulWidget {
  const EmptyCheckedCard({Key? key}) : super(key: key);

  @override
  State<EmptyCheckedCard> createState() => _EmptyCheckedCardState();
}

class _EmptyCheckedCardState extends State<EmptyCheckedCard> {
  Widget _textWidget(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }

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
            flex: 9,
            child: Lottie.asset('assets/lotties/empty_card.json'),
          ),
          const SizedBox(height: 48),
          _textWidget("'좋아요'를 누른 메뉴카드가 없어요"),
          const SizedBox(height: 4),
          _textWidget("메인 화면에서 메뉴 카드를"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "LIKE PICK",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              _textWidget("해보세요!"),
            ],
          ),
          Flexible(
            flex: 2,
            child: Container(),
          ),
        ],
      ),
    );
  }
}

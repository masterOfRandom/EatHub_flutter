import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SetRangeDialog extends StatefulWidget {
  const SetRangeDialog({Key? key}) : super(key: key);

  @override
  State<SetRangeDialog> createState() => _SetRangeDialogState();
}

class _SetRangeDialogState extends State<SetRangeDialog> {
  final controller = Get.put(GController());
  late double range;

  double indexToRange(int i) {
    switch (i) {
      case 0:
        return 100;
      case 1:
        return 200;
      case 2:
        return 500;
      case 3:
        return 1000;
      case 4:
        return 2000;
      case 5:
        return 3000;
      case 6:
        return 5000;
      default:
        return 500;
    }
  }

  int rangeToIndex(int range) {
    switch (range) {
      case 100:
        return 0;
      case 200:
        return 1;
      case 500:
        return 2;
      case 1000:
        return 3;
      case 2000:
        return 4;
      case 3000:
        return 5;
      case 5000:
        return 6;
      default:
        return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    range = rangeToIndex(controller.range.value).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text(
        '거리설정',
        style: TextStyle(color: primaryRedColor),
      ),
      content: Column(
        children: [
          const Text('주변 식당을 탐색하는\n거리 범위를 설정해보세요'),
          CupertinoSlider(
            thumbColor: primaryRedColor,
            activeColor: primaryRedColor,
            value: range,
            onChanged: (value) {
              range = value;
              setState(() {});
            },
            min: 0,
            max: 6,
            divisions: 6,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: Text('${indexToRange(range.toInt()).toInt()}m'),
          )
        ],
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('취소'),
          textStyle: const TextStyle(color: grayScaleGray3),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          child: const Text('적용'),
          textStyle: const TextStyle(color: primaryRedColor),
          onPressed: () {
            controller.setRange(indexToRange(range.toInt()).toInt());
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

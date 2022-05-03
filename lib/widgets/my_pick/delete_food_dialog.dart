import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/models/checked_food.dart';
import 'package:eathub/resources/shared_preference_methods.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DeleteFoodDialog extends StatefulWidget {
  final CheckedFood food;

  const DeleteFoodDialog({Key? key, required this.food}) : super(key: key);

  @override
  State<DeleteFoodDialog> createState() => _DeleteFoodDialogState();
}

class _DeleteFoodDialogState extends State<DeleteFoodDialog> {
  final controller = Get.put(GController());

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        '${widget.food.name}을 삭제하시겠습니까?',
        style: TextStyle(color: primaryRedColor),
      ),
      content: Text('삭제된 음식은 다시 추천될 수 있습니다',
          style: TextStyle(color: grayScaleGray2)),
      actions: [
        CupertinoDialogAction(
          child: Text('취소'),
          textStyle:
              TextStyle(color: grayScaleGray3, fontWeight: FontWeight.w700),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          child: Text('삭제'),
          textStyle: TextStyle(color: primaryRedColor),
          onPressed: () async {
            await controller.deleteCheckedFood(widget.food);
            await controller.updateCheckedFoods();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

import 'package:eathub/presentation/table_pick_icons.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetBackIconButton extends StatelessWidget {
  const GetBackIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Icon(TablePick.arrow_back_ios_new, color: grayScaleGray2),
      onTap: () {
        Get.back();
      },
    );
  }
}

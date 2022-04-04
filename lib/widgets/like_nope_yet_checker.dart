import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikeNopeYetChecker extends StatefulWidget {
  const LikeNopeYetChecker({Key? key}) : super(key: key);

  @override
  State<LikeNopeYetChecker> createState() => _LikeNopeYetCheckerState();
}

class _LikeNopeYetCheckerState extends State<LikeNopeYetChecker> {
  final controller = Get.put(GController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        var opacity = controller.statusPoint.value / 200;
        if (opacity > 1) {
          opacity = 1;
        }

        return Opacity(
          opacity: opacity,
          child: Builder(
            builder: (_) {
              final status = controller.status.value;

              if (status == CardStatus.like) {
                return const Icon(
                  Icons.favorite,
                  size: 200,
                  color: Colors.white,
                );
              } else if (status == CardStatus.nope) {
                return const Icon(
                  Icons.close_rounded,
                  size: 200,
                  color: Colors.white,
                );
              } else {
                return const Icon(
                  Icons.star,
                  size: 200,
                  color: Colors.white,
                );
              }
            },
          ),
        );
      }),
    );
  }
}

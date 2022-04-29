import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:eathub/widgets/introduce/introduce_list.dart';
import 'package:eathub/widgets/my_page/logout_button.dart';
import 'package:eathub/widgets/my_page/my_page_list.dart';
import 'package:eathub/widgets/my_page/say_hello_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroduceScreen extends StatefulWidget {
  const IntroduceScreen({Key? key}) : super(key: key);

  @override
  State<IntroduceScreen> createState() => _IntroduceScreenState();
}

class _IntroduceScreenState extends State<IntroduceScreen> {
  final controller = Get.put(GController());
  final userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: grayScaleGray3,
        backgroundColor: backgroundWhiteColor,
        title: const Text(
          '테이블픽 소개',
          style: pageTitleTextStyle,
        ),
        elevation: 0,
      ),
      body: Container(
        color: backgroundLightPinkColor,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            const IntroduceList(),
          ],
        ),
      ),
    );
  }
}

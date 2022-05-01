import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:eathub/widgets/my_page/logout_button.dart';
import 'package:eathub/widgets/my_page/my_page_list.dart';
import 'package:eathub/widgets/my_page/say_hello_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(GController());
  final userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundWhiteColor,
        title: const Text(
          'My page',
          style: mainTitleTextStyle,
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
            SizedBox(height: 20),
            Obx(() => SayHelloText(name: userController.user.value.name)),
            const SizedBox(height: 52),
            const MyPageList(),
          ],
        ),
      ),
    );
  }
}

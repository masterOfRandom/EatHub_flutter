import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/screens/mypick_screens.dart/like_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPickScreen extends StatefulWidget {
  const MyPickScreen({Key? key}) : super(key: key);

  @override
  State<MyPickScreen> createState() => _MyPickScreenState();
}

class _MyPickScreenState extends State<MyPickScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(GController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundWhiteColor,
        title: const Text(
          'My pick',
          style: mainTitleTextStyle,
        ),
        elevation: 0,
      ),
      backgroundColor: backgroundWhiteColor,
      body: Obx(() {
        final likedFoods = controller.checkedFoods
            .where((element) => element.status == CardStatus.like)
            .toList();
        return LikeScreen(
          likedFoods: likedFoods,
        );
      }),
    );
  }
}

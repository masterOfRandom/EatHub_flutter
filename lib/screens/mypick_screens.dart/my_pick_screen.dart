import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/screens/mypick_screens.dart/like_screen.dart';
import 'package:eathub/screens/mypick_screens.dart/nope_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MyPickScreen extends StatefulWidget {
  const MyPickScreen({Key? key}) : super(key: key);

  @override
  State<MyPickScreen> createState() => _MyPickScreenState();
}

class _MyPickScreenState extends State<MyPickScreen> {
  final controller = Get.put(GController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundWhiteColor,
          title: SvgPicture.asset('assets/images/my_pick_logo.svg'),
          elevation: 0,
        ),
        body: Scaffold(
          backgroundColor: backgroundLightPinkColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: backgroundLightPinkColor,
            flexibleSpace: const TabBar(
              indicatorColor: primaryRedColor,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Text(
                    'like',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'nope',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Container(
                padding: EdgeInsets.all(10),
                child: Obx(
                  () {
                    final likedFoods = controller.checkedFoods
                        .where((element) => element.status == CardStatus.like)
                        .toList();
                    final nopedFoods = controller.checkedFoods
                        .where((element) => element.status == CardStatus.nope)
                        .toList();
                    return TabBarView(children: [
                      LikeScreen(likedFoods: likedFoods),
                      NopeScreen(nopedFoods: nopedFoods),
                    ]);
                  },
                )),
          ),
        ),
      ),
    );
  }
}

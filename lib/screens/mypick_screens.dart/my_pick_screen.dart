import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/presentation/table_pick_icons.dart';
import 'package:eathub/screens/mypick_screens.dart/like_screen.dart';
import 'package:eathub/screens/mypick_screens.dart/nope_screen.dart';
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
      body: Obx(() {
        final likedFoods = controller.checkedFoods
            .where((element) => element.status == CardStatus.like)
            .toList();
        return LikeScreen(
          likedFoods: likedFoods,
        );
      }),
    );

    // return DefaultTabController(
    //   length: 2,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       centerTitle: true,
    //       backgroundColor: backgroundWhiteColor,
    //       title: const Text(
    //         'My pick',
    //         style: mainTitleTextStyle,
    //       ),
    //       elevation: 0,
    //     ),
    //     body: Scaffold(
    //       backgroundColor: backgroundLightPinkColor,
    //       appBar: AppBar(
    //         elevation: 0,
    //         backgroundColor: backgroundLightPinkColor,
    //         flexibleSpace: TabBar(
    //           onTap: (_) => setState(() {}),
    //           controller: _tabController,
    //           indicatorColor: primaryRedColor,
    //           indicatorSize: TabBarIndicatorSize.label,
    //           unselectedLabelColor: secondaryPinkGrayColor,
    //           labelColor: primaryRedColor,
    //           indicatorWeight: 4,
    //           tabs: const [
    //             Tab(
    //               height: 80,
    //               icon: Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 40),
    //                 child: Icon(
    //                   TablePick.smallHeart,
    //                 ),
    //               ),
    //             ),
    //             Tab(
    //               icon: Padding(
    //                 padding: EdgeInsets.symmetric(horizontal: 40),
    //                 child: Icon(
    //                   TablePick.smallx,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       body: SafeArea(
    //         child: Container(
    //           color: backgroundWhiteColor,
    //           padding: const EdgeInsets.all(10),
    //           child: Obx(
    //             () {
    //               final likedFoods = controller.checkedFoods
    //                   .where((element) => element.status == CardStatus.like)
    //                   .toList();
    //               final nopedFoods = controller.checkedFoods
    //                   .where((element) => element.status == CardStatus.nope)
    //                   .toList();
    //               return TabBarView(
    //                 physics: const NeverScrollableScrollPhysics(),
    //                 controller: _tabController,
    //                 children: [
    //                   LikeScreen(likedFoods: likedFoods),
    //                   NopeScreen(nopedFoods: nopedFoods),
    //                 ],
    //               );
    //             },
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

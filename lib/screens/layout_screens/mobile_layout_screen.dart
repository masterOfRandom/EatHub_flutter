import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/presentation/table_pick_icons.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MobileLayoutScreen extends StatefulWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  State<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends State<MobileLayoutScreen> {
  int selectedIndex = 0;
  bool isLoading = false;
  final controller = Get.put(UserController());
  final gController = Get.put(GController());

  initCheckedFoods() async {
    setState(() {
      isLoading = true;
    });
    await gController.initCheckedFoods();
    setState(() {
      isLoading = false;
    });
  }

  final _items = const [
    BottomNavigationBarItem(
      icon: Icon(
        TablePick.card,
        size: 18,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        TablePick.smallHeart,
        size: 18,
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        TablePick.contacts,
        size: 18,
      ),
      label: '',
    ),
  ];

  @override
  void initState() {
    super.initState();
    controller.refreshUser();
    initCheckedFoods();
    gController.randomIndexInit();
  }

  @override
  Widget build(BuildContext context) {
    final indicatorLength = MediaQuery.of(context).size.width / _items.length;
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            elevation: 0,
            backgroundColor: backgroundWhiteColor,
            onTap: ((value) {
              setState(() => selectedIndex = value);
            }),
            currentIndex: selectedIndex,
            selectedItemColor: primaryRedColor,
            unselectedItemColor: grayScaleGray4,
            enableFeedback: false,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            type: BottomNavigationBarType.fixed,
            items: _items,
          ),
          AnimatedPositioned(
            top: 0,
            curve: Curves.ease,
            duration: const Duration(milliseconds: 200),
            left: selectedIndex * indicatorLength + indicatorLength / 8,
            child: Container(
              height: 2,
              color: primaryRedColor,
              width: indicatorLength * 3 / 4,
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: primaryRedColor,
            ))
          : homeScreenItems[selectedIndex],
    );
  }
}

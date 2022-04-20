import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/presentation/custom_icon_icons.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MobileLayoutScreen extends StatefulWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  State<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends State<MobileLayoutScreen> {
  int selectedIndex = 0;
  final controller = Get.put(UserController());
  final gController = Get.put(GController());

  @override
  void initState() {
    super.initState();
    controller.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      bottomNavigationBar: BottomNavigationBar(
        onTap: ((value) {
          setState(() => selectedIndex = value);
        }),
        currentIndex: selectedIndex,
        selectedItemColor: primaryRedColor,
        unselectedItemColor: grayScaleGray4,
        enableFeedback: false,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcon.cards,
              size: 18,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcon.community,
              size: 20,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'hihi',
          ),
        ],
      ),
      body: homeScreenItems[selectedIndex],
    );
  }
}

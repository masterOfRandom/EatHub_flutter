import 'package:eathub/presentation/custom_icon_icons.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:flutter/material.dart';

class MobileLayoutScreen extends StatefulWidget {
  const MobileLayoutScreen({Key? key}) : super(key: key);

  @override
  State<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends State<MobileLayoutScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          title: Image(
            image: Image.asset('assets/eathub_title_logo.png').image,
          )),
      bottomNavigationBar: BottomNavigationBar(
        onTap: ((value) {
          setState(() => selectedIndex = value);
        }),
        currentIndex: selectedIndex,
        selectedItemColor: secondaryColor,
        unselectedItemColor: Colors.grey,
        enableFeedback: false,
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
            label: '',
          ),
        ],
      ),
      body: homeScreenItems[selectedIndex],
    );
  }
}

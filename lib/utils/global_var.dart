import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/screens/mypick_screens.dart/my_pick_screen.dart';
import 'package:eathub/screens/select_card_screen/select_card_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const defaultFoodImageUrl =
    'https://i.pinimg.com/564x/dd/9d/c9/dd9dc9d83423bc037b511d73b29e6b80.jpg';

enum CardStatus { like, yet, nope, nothing }
const cardReturnMillisecond = 400;

class TestWidget extends StatefulWidget {
  const TestWidget({Key? key}) : super(key: key);

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final user = controller.user.value;
      final profileUrl = user.profileUrl;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(backgroundImage: Image.network(profileUrl!).image),
          Text('name : ${user.name}'),
          Text('email : ${user.email}'),
          Text('birthday : ${user.birthday!.toDate()}'),
          ElevatedButton(
            child: Text('이메일 중복 확인'),
            onPressed: () {
              final user = FirebaseAuth.instance.currentUser!;
              final isBlank = FirebaseFirestore.instance
                  .collection('email_valid')
                  .doc(user.email)
                  .isBlank;
              if (isBlank == false) {
                Get.snackbar('유저 정보',
                    'displayname : ${user.displayName} \n email : ${user.email}\n phoneNumber: ${user.phoneNumber} \n uid : ${user.uid} \n photoURL: ${user.photoURL}\n');
              }
              // 유저 정보가 제대로 들어가는지.
              controller.refreshUser();
            },
          ),
        ],
      );
    });
  }
}

List<Widget> homeScreenItems = [
  const SelectCardScreen(),
  const MyPickScreen(),
  const TestWidget(),
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('profile'),
      ElevatedButton(
        onPressed: () => AuthMethods().logOut(),
        child: Text('Log out'),
      ),
    ],
  ),
];

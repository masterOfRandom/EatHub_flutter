import 'package:cached_network_image/cached_network_image.dart';
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

List<Widget> homeScreenItems = [
  const SelectCardScreen(),
  const MyPickScreen(),
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () {
          final controller = Get.put(GController());
          controller.removeCheckedFoods();
          controller.removeFoods();
          AuthMethods().logOut();
        },
        child: Text('Log out'),
      ),
    ],
  ),
];

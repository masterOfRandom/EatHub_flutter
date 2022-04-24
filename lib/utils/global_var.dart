import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/resources/shared_preference_methods.dart';
import 'package:eathub/screens/my_page_screens/my_page_screen.dart';
import 'package:eathub/screens/mypick_screens.dart/my_pick_screen.dart';
import 'package:eathub/screens/select_card_screen/select_card_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

const defaultFoodImageUrl =
    'https://i.pinimg.com/564x/dd/9d/c9/dd9dc9d83423bc037b511d73b29e6b80.jpg';

enum CardStatus { like, yet, nope, nothing }

const cardReturnMillisecond = 400;
const mainTitleTextStyle = TextStyle(
    fontFamily: 'Baloo2',
    fontWeight: FontWeight.w900,
    color: primaryRedColor,
    fontSize: 32);
List<Widget> homeScreenItems = [
  const MyPageScreen(),
  const SelectCardScreen(),
  const MyPickScreen(),
];

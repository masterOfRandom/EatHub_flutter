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
const termsOfServiceUrl =
    'https://100000000.notion.site/29df5c6fe30f4e9ea1b15158d8415e38';
const termsOfPrivacyPolicyUrl =
    'https://100000000.notion.site/018ccd8b888b48568bede7438a2752d5';
const termsOfLocationPolicyUrl =
    'https://100000000.notion.site/5181ae16ba9240c093083fdfac322966';

enum CardStatus { like, yet, nope, nothing }

const cardReturnMillisecond = 400;
const mainTitleTextStyle = TextStyle(
    fontFamily: 'Baloo2',
    fontWeight: FontWeight.w900,
    color: primaryRedColor,
    fontSize: 32);
const pageTitleTextStyle = TextStyle(
    fontWeight: FontWeight.w500, color: primaryBlackColor, fontSize: 20);
List<Widget> homeScreenItems = [
  const SelectCardScreen(),
  const MyPickScreen(),
  const MyPageScreen(),
];

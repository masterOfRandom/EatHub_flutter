import 'package:eathub/screens/my_page_screens/my_page_screen.dart';
import 'package:eathub/screens/mypick_screens.dart/my_pick_screen.dart';
import 'package:eathub/screens/select_card_screen/select_card_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';

const defaultFoodImageUrl =
    'https://i.pinimg.com/564x/dd/9d/c9/dd9dc9d83423bc037b511d73b29e6b80.jpg';
const termsOfServiceUrl =
    'https://100000000.notion.site/29df5c6fe30f4e9ea1b15158d8415e38';
const termsOfPrivacyPolicyUrl =
    'https://100000000.notion.site/018ccd8b888b48568bede7438a2752d5';
const termsOfLocationPolicyUrl =
    'https://100000000.notion.site/5181ae16ba9240c093083fdfac322966';

enum CardStatus { like, yet, nope, nothing }

const cardReturnMillisecond = 700;
const mainTitleTextStyle = TextStyle(
  fontFamily: 'Baloo2',
  fontWeight: FontWeight.w900,
  color: primaryRedColor,
  fontSize: 26,
);
const pageTitleTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  color: primaryBlackColor,
  fontSize: 20,
);
List<Widget> homeScreenItems = [
  const SelectCardScreen(),
  const MyPickScreen(),
  const MyPageScreen(),
];

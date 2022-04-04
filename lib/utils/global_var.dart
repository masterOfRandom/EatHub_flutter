import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/screens/select_card_screen.dart';
import 'package:flutter/material.dart';

enum CardStatus { like, yet, nope, nothing }
const cardReturnMillisecond = 400;

List<Widget> homeScreenItems = [
  const SelectCardScreen(),
  const Center(
    child: Text('favorite'),
  ),
  const Center(
    child: Text('community'),
  ),
  Center(
    child: Column(
      children: [
        Text('profile'),
        ElevatedButton(
          onPressed: () => AuthMethods().logOut(),
          child: Text('Log out'),
        ),
      ],
    ),
  ),
];

import 'package:eathub/screens/select_card_screen.dart';
import 'package:flutter/material.dart';

enum CardStatus { like, yet, nope }
const cardReturnMillisecond = 400;

const List<Widget> homeScreenItems = [
  SelectCardScreen(),
  Center(
    child: Text('favorite'),
  ),
  Center(
    child: Text('community'),
  ),
  Center(
    child: Text('profile'),
  ),
];

import 'package:eathub/models/restautant.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';

class RestaurantListView extends StatelessWidget {
  final KakaoRestaurants kakaoRestaurants;
  const RestaurantListView({Key? key, required this.kakaoRestaurants})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: kakaoRestaurants.list.map((e) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: backgroundWhiteColor,
                ),
                child: Column(
                  children: [
                    Text(
                      e.placeName,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      e.addressName,
                      style: const TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }
}

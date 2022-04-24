import 'package:cached_network_image/cached_network_image.dart';
import 'package:eathub/models/checked_food.dart';
import 'package:eathub/screens/restaurant_list_screens/restaurant_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NopeScreen extends StatelessWidget {
  final List<CheckedFood> nopedFoods;

  const NopeScreen({Key? key, required this.nopedFoods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      crossAxisCount: 3,
      children: nopedFoods.map((e) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Get.to(RestaurantListScreen(foodName: e.name));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: e.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

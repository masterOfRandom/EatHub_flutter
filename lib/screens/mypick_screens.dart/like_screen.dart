import 'package:eathub/models/checked_food.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LikeScreen extends StatelessWidget {
  final List<CheckedFood> likedFoods;

  const LikeScreen({Key? key, required this.likedFoods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      crossAxisCount: 3,
      children: likedFoods.map((e) {
        return GridTile(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              e.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }
}

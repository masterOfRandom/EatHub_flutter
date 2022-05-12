import 'package:cached_network_image/cached_network_image.dart';
import 'package:eathub/models/checked_food.dart';
import 'package:eathub/widgets/my_pick/delete_food_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              showCupertinoDialog(
                  context: context,
                  builder: (_) {
                    return DeleteFoodDialog(food: e);
                  });
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

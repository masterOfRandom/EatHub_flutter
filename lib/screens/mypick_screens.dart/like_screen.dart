import 'package:eathub/models/checked_food.dart';
import 'package:eathub/screens/restaurant_list_screens/restaurant_list_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LikeScreen extends StatelessWidget {
  final List<CheckedFood> likedFoods;

  const LikeScreen({Key? key, required this.likedFoods}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return likedFoods.isNotEmpty
        ? GridView.count(
            padding: EdgeInsets.all(10),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
            children: likedFoods.map((e) {
              return GestureDetector(
                onTap: () {
                  Get.to(RestaurantListScreen(foodName: e.name));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      // Container(color: Colors.red),
                      Image.network(
                        e.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0, 1),
                            end: Alignment(0, 0.4),
                            colors: [
                              Colors.black.withOpacity(1),
                              Colors.black.withOpacity(0),
                              Colors.white.withOpacity(0),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          alignment: Alignment.center,
                          height: 52,
                          child: Text(
                            e.name,
                            style: TextStyle(
                              color: backgroundWhiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        : const Center(
            child: Text('좋아요한 음식이 없습니다'),
          );
  }
}

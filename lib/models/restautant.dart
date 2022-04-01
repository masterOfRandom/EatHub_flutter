import 'package:flutter/material.dart';

class Restaurant {
  final String name;
  final String imageUrl;
  final String address;
  final String menu;
  final double rating;

  const Restaurant({
    required this.name,
    required this.imageUrl,
    required this.address,
    required this.menu,
    required this.rating,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'imageUrl': imageUrl,
        'address': address,
        'menu': menu,
        'rating': rating,
      };
}

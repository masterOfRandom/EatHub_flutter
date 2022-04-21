import 'package:flutter/material.dart';

class KakaoRestaurant {
  final String placeName;
  final String placeUrl;
  final String addressName;
  final String roadAddressName;
  final String categoryGroupCode;
  final String categoryGroupName;
  final String x;
  final String y;

  const KakaoRestaurant({
    required this.placeName,
    required this.placeUrl,
    required this.addressName,
    required this.roadAddressName,
    required this.categoryGroupCode,
    required this.categoryGroupName,
    required this.x,
    required this.y,
  });

  factory KakaoRestaurant.fromJson(dynamic data) {
    return KakaoRestaurant(
      placeName: data['place_name'],
      placeUrl: data['place_url'],
      addressName: data['address_name'],
      roadAddressName: data['road_address_name'],
      categoryGroupCode: data['category_group_code'],
      categoryGroupName: data['category_group_name'],
      x: data['x'],
      y: data['y'],
    );
  }
}

class KakaoRestaurants {
  const KakaoRestaurants({required this.list});
  final List<KakaoRestaurant> list;

  factory KakaoRestaurants.fromJson(Map<String, dynamic> data) {
    final list = data['documents'] as List<dynamic>;
    final result = list.map((e) => KakaoRestaurant.fromJson(e)).toList();
    return KakaoRestaurants(list: result);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/widgets/etc/get_back_icon_button.dart';
import 'package:eathub/models/restautant.dart';
import 'package:eathub/resources/kakao_methods.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:eathub/widgets/restaurant_list/food_name_container.dart';
import 'package:eathub/widgets/restaurant_list/restaurants_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class RestaurantListScreen extends StatefulWidget {
  final String foodName;

  const RestaurantListScreen({Key? key, required this.foodName})
      : super(key: key);

  @override
  State<RestaurantListScreen> createState() => _AroundRestaurantListState();
}

class _AroundRestaurantListState extends State<RestaurantListScreen> {
  LocationData? _locationData;
  KakaoRestaurants? kakaoRestaurants;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    getLocation().then((value) {
      _locationData = value;
      if (_locationData != null) {
        KakaoMethods()
            .getKakaoRestaurants(_locationData!, widget.foodName)
            .then((value) {
          kakaoRestaurants = value;
          isLoading = false;
          setState(() {});
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLightPinkColor,
      appBar: AppBar(
        centerTitle: true,
        leading: const GetBackIconButton(),
        backgroundColor: backgroundWhiteColor,
        elevation: 0,
        title: Text('Tablepick', style: mainTitleTextStyle),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              FoodNameContainer(foodName: widget.foodName),
              const SizedBox(height: 20),
              isLoading == true ||
                      _locationData == null ||
                      kakaoRestaurants == null
                  ? const CircularProgressIndicator(color: primaryRedColor)
                  : RestaurantListView(kakaoRestaurants: kakaoRestaurants!),
            ],
          ),
        ),
      ),
    );
  }
}

Future<LocationData?> getLocation() async {
  Location location = Location();

  bool serviceEnabled;
  PermissionStatus permissionGranted;
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return null;
    }
  }
  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      Get.snackbar('위치 접근 허용이 안되어 있습니다.',
          '설정 -> TablePick -> 위치 에서 앱을 사용하는 동안 혹은 항상을 체크해주세요.',
          duration: const Duration(seconds: 10));
      return null;
    }
  }
  return await location.getLocation();
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/models/restautant.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class AroundRestaurantList extends StatefulWidget {
  final String foodName;

  const AroundRestaurantList({Key? key, required this.foodName})
      : super(key: key);

  @override
  State<AroundRestaurantList> createState() => _AroundRestaurantListState();
}

class _AroundRestaurantListState extends State<AroundRestaurantList> {
  LocationData? _locationData;

  // Future<List<Restaurant>> getRestaurants() async {
  //   //

  // }

  getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        Get.snackbar('위치 접근 허용이 안되어 있습니다.',
            '설정 -> TablePick -> 위치 에서 앱을 사용하는 동안 혹은 항상을 체크해주세요.',
            duration: Duration(seconds: 10));
        return;
      }
    }
    _locationData = await location.getLocation();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundLightPinkColor,
        appBar: AppBar(
          foregroundColor: grayScaleGray3,
          backgroundColor: backgroundWhiteColor,
          elevation: 0,
          title: SvgPicture.asset('assets/images/table_pick_logo.svg'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                FoodNameContainer(foodName: widget.foodName),
                SizedBox(height: 20),
                _locationData == null
                    ? CircularProgressIndicator()
                    : Text(
                        '${_locationData!.latitude} : ${_locationData!.longitude}'),
              ],
            ),
          ),
        ));
  }
}

class FoodNameContainer extends StatelessWidget {
  final String foodName;
  const FoodNameContainer({Key? key, required this.foodName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backgroundWhiteColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '내 근처의 ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '${foodName}집',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// class KaKaoRestaurantsList extends StatelessWidget {
//   const KaKaoRestaurantsList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(

//     );
//   }
// }

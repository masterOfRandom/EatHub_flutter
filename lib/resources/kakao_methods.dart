import 'dart:convert';

import 'package:eathub/env.dart';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/models/restautant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';

class KakaoMethods {
  final controller = Get.put(GController());
  Future<KakaoRestaurants> getKakaoRestaurants(
      LocationData locationData, String food) async {
    final uri = Uri.parse(
        'https://dapi.kakao.com/v2/local/search/keyword.json?y=${locationData.latitude}&x=${locationData.longitude}&radius=${controller.range}&category_group_code=FD6&query=$food');
    final json = await get(uri,
        headers: {'Authorization': 'KakaoAK $KAKAO_REST_API_KEY'});
    final parsedJson = jsonDecode(json.body);
    final kakaoRestaurants = KakaoRestaurants.fromJson(parsedJson);
    return kakaoRestaurants;
  }
}

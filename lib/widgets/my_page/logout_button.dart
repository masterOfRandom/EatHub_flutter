import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          final controller = Get.put(GController());
          controller.removeCheckedFoods();
          controller.removeFoods();
          AuthMethods().logOut();
        },
        child: Text('logout'));
  }
}

import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/main.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/screens/login_screens/login_profile_screen.dart';
import 'package:eathub/screens/login_screens/signup_password_screen.dart';
import 'package:eathub/screens/mobile_layout_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/widgets/next_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPasswordScreen extends StatefulWidget {
  const LoginPasswordScreen({Key? key}) : super(key: key);

  @override
  State<LoginPasswordScreen> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordScreen> {
  final passwordController = TextEditingController();
  final controller = Get.put(LoginController());
  final userController = Get.put(UserController());
  String? errMessage;
  var isLoading = false;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void _nextButtonCallback() async {
    final password = passwordController.text;
    setState(() {
      isLoading = true;
    });
    if (password.isEmpty) {
      setState(() {
        errMessage = '입력창이 비어있습니다.';
      });
    } else {
      controller.updatePassword(password: password);
      final state = await AuthMethods()
          .signIn(controller.email.value, controller.password.value);
      if (state == SignState.success) {
        userController.refreshUser();
        Get.back();
        Get.back();
        Get.snackbar('로그인 성공', '로그인에 성공하셨습니다!');
      } else if (state == SignState.wrongPassword) {
        errMessage = '비밀번호가 틀립니다.';
      } else if (state == SignState.userNotFound) {
        Get.snackbar('에러', '유저가 존재하지 않습니다. 고객센터에 문의하세요.');
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: mobileBackgroundGrayColor,
          elevation: 0,
        ),
        body: Container(
          color: mobileBackgroundGrayColor,
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 28),
              Text(
                '비밀번호 입력',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                '비밀번호',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                style: TextStyle(color: grayScaleGray2, fontSize: 14),
                keyboardType: TextInputType.emailAddress,
                controller: passwordController,
                decoration: InputDecoration(
                  errorText: errMessage,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: primaryRedColor)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: grayScaleGray4),
                  ),
                ),
              ),
              Expanded(child: Container()),
              NextButton(
                callback: _nextButtonCallback,
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

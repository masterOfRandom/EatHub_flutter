import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/screens/login_screens/login_password_screen.dart';
import 'package:eathub/screens/login_screens/signup_password_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/widgets/login/login_input_text_field.dart';
import 'package:eathub/widgets/next_button.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({Key? key}) : super(key: key);

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  final controller = Get.put(LoginController());
  final emailController = TextEditingController();
  String? errMessage;
  var isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _nextButtonCallback() async {
    final email = emailController.text;
    setState(() {
      isLoading = true;
      errMessage = null;
    });
    if (email.isEmpty) {
      setState(() {
        errMessage = '입력창이 비어있습니다.';
      });
    } else if (!EmailValidator.validate(email)) {
      setState(() {
        errMessage = '이메일 형식이 올바르지 않습니다.';
      });
    } else {
      // 중복 확인.
      final isOverlap = await AuthMethods().isEmailOverlaped(email);
      controller.updateEmail(email: email);
      if (isOverlap) {
        Get.to(LoginPasswordScreen());
      } else {
        Get.to(SignupPasswordScreen());
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
        backgroundColor: backgroundWhiteColor,
        appBar: AppBar(
          foregroundColor: grayScaleGray3,
          backgroundColor: backgroundWhiteColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: backgroundWhiteColor,
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28),
                Text(
                  '이메일로 시작',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  '이메일',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 8,
                ),
                LoginInputTextField(controller: emailController),
              ],
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: NextButton(
            callback: _nextButtonCallback,
            isLoading: isLoading,
          ),
        ),
      ),
    );
  }
}

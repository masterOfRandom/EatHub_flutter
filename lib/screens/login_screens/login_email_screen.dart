import 'package:eathub/widgets/confirm_dialog.dart';
import 'package:eathub/widgets/etc/get_back_icon_button.dart';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/screens/login_screens/login_password_screen.dart';
import 'package:eathub/screens/login_screens/signup_password_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/widgets/login/login_input_text_field.dart';
import 'package:eathub/widgets/table_pick_elevated_button.dart';
import 'package:flutter/cupertino.dart';
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
    });
    if (email.isEmpty) {
      errMessage = '입력창이 비어있습니다.';
    } else if (!EmailValidator.validate(email)) {
      errMessage = '이메일 형식이 올바르지 않습니다.';
    } else {
      // 중복 확인.
      final isOverlap = await AuthMethods().isEmailOverlaped(email);
      controller.updateEmail(email: email);
      if (isOverlap) {
        Get.to(const LoginPasswordScreen());
      } else {
        Get.to(const SignupPasswordScreen());
      }
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: backgroundWhiteColor,
        appBar: AppBar(
          leading: const GetBackIconButton(),
          backgroundColor: backgroundWhiteColor,
          elevation: 0,
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                child: const Text(
                  '고객문의',
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () => showCupertinoDialog(
                  context: context,
                  builder: (_) => const ConfirmDialog(
                    title: '이메일 문의',
                    content: ('tablepick2022@gmail.com로\n문의 해주세요'),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: backgroundWhiteColor,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),
                const Text(
                  '이메일로 시작',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  '이메일',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                LoginInputTextField(
                  controller: emailController,
                  errText: errMessage,
                  hintText: '이메일을 입력해주세요',
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: TablePickElevatedButton(
            text: '다음',
            callback: _nextButtonCallback,
            isLoading: isLoading,
          ),
        ),
      ),
    );
  }
}

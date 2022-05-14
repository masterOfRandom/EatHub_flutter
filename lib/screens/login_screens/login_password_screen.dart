import 'package:eathub/confirm_dialog.dart';
import 'package:eathub/widgets/etc/get_back_icon_button.dart';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/widgets/login/login_input_text_field.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/table_pick_elevated_button.dart';
import 'package:flutter/cupertino.dart';
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
        FocusManager.instance.primaryFocus?.unfocus();
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
                  '비밀번호 입력',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  '비밀번호',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                LoginInputTextField(
                  controller: passwordController,
                  errText: errMessage,
                  isPassword: true,
                  hintText: '비밀번호를 입력해 주세요',
                  isLogin: true,
                ),
                const SizedBox(height: 70),
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

import 'package:eathub/widgets/etc/get_back_icon_button.dart';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/widgets/login/login_input_text_field.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/screens/login_screens/login_profile_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/table_pick_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPasswordScreen extends StatefulWidget {
  const SignupPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SignupPasswordScreen> createState() => _SignupPasswordScreenState();
}

class _SignupPasswordScreenState extends State<SignupPasswordScreen> {
  final passwordController = TextEditingController();
  final passwordCheckerController = TextEditingController();
  final controller = Get.put(LoginController());
  final passwordFocusNode = FocusNode();
  final passwordCheckerFocusNode = FocusNode();
  var isLoading = false;
  bool isPasswordPass = false;
  String? errMessage;
  String? checkerErrMessage;

  @override
  void initState() {
    super.initState();
    passwordFocusNode.addListener(() {
      // 비밀번호 적합성 판단
      _isPasswordPassed();
    });

    passwordCheckerFocusNode.addListener(() {
      final password = passwordController.text;
      final checker = passwordCheckerController.text;

      if (password == checker) {
        setState(() {
          checkerErrMessage = null;
        });
      } else {
        setState(() {
          checkerErrMessage = '비밀번호가 일치하지 않습니다.';
        });
      }
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    passwordCheckerController.dispose();
    passwordFocusNode.dispose();
    passwordCheckerFocusNode.dispose();
    super.dispose();
  }

  void _isPasswordPassed() {
    final password = passwordController.text;
    final checker = passwordCheckerController.text;

    if (password.isEmpty) {
      errMessage = '비밀번호가 비었습니다.';
    } else {
      // 비밀번호는 8자리 이상,
      // 영어, 숫자가 하나 이상씩 섞여야한다.
      errMessage = null;
      setState(() {
        isPasswordPass = false;
      });
      if (!password.contains(new RegExp(r'[0-9]')) ||
          !password.contains(new RegExp(r'[a-zA-Z]')) ||
          !password.contains(new RegExp(r'[!@#$%^*+=-]')) ||
          password.length < 8) {
        setState(() {
          errMessage = '비밀번호는 영문, 숫자, 특수문자(!@#\$%^*+=-) 조합 8자 이상이어야 합니다.';
        });
      } else {
        setState(() {
          errMessage = null;
          isPasswordPass = true;
        });
        if (checker != password) {
          setState(() {
            checkerErrMessage = '비밀번호가 일치하지 않습니다.';
          });
        } else {
          setState(() {
            checkerErrMessage = null;
          });
        }
      }
    }
  }

  void _nextButtonCallback() async {
    final password = passwordController.text;
    final checker = passwordCheckerController.text;
    // passwordFocusNode.unfocus();
    // passwordCheckerFocusNode.unfocus();
    setState(() {
      isLoading = true;
    });
    _isPasswordPassed();
    // 둘 다 합격체크 bool을 넣자.
    if (password.isEmpty) {
      setState(() {
        errMessage = '입력창이 비어있습니다.';
      });
    } else {
      if (password == checker && isPasswordPass) {
        controller.updatePassword(password: password);
        Get.to(LoginProfileScreen());
      } else {
        setState(() {
          checkerErrMessage = '비밀번호가 일치하지 않습니다.';
        });
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
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28),
                Text(
                  '이메일 회원가입',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 40),
                Text(
                  '비밀번호',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                LoginInputTextField(
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  errText: errMessage,
                  isPassword: true,
                ),
                SizedBox(height: 40),
                Text(
                  '비밀번호 확인',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                LoginInputTextField(
                  focusNode: passwordCheckerFocusNode,
                  controller: passwordCheckerController,
                  errText: checkerErrMessage,
                  isPassword: true,
                ),
                SizedBox(height: 70),
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

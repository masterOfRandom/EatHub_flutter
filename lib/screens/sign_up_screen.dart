import 'package:eathub/main.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final idController = TextEditingController();
  final pwController = TextEditingController();
  bool isSignUpLoading = false;

  @override
  void dispose() {
    super.dispose();
    idController.dispose();
    pwController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              child: TextField(
                decoration: InputDecoration(hintText: '이메일'),
                controller: idController,
              ),
            ),
            Container(
              height: 50,
              child: TextField(
                decoration: InputDecoration(hintText: '비밀번호'),
                controller: pwController,
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                isSignUpLoading = true;

                final result = await AuthMethods()
                    .signUp(idController.text, pwController.text);
                if (result == SignState.err) {
                  print('err다~!!!');
                  setState(() {
                    isSignUpLoading = false;
                  });
                } else if (result == SignState.success) {
                  Get.snackbar('회원가입 완료!!', '이메일 인증을 완료하고 EatHub를 이용해보세요!!');
                  Navigator.pop(context);
                } else {
                  print('else다!!!!!!!!!!!!!!!!!!');
                }
                setState(() {});
              },
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';

class LoginInputForm extends StatefulWidget {
  const LoginInputForm({Key? key}) : super(key: key);

  @override
  State<LoginInputForm> createState() => _LoginInputFormState();
}

class _LoginInputFormState extends State<LoginInputForm> {
  final idController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  Widget _inputBox(
      {required final TextEditingController controller,
      required final String hintText,
      final bool isPassword = false}) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: Color(0xFFF1F1F5),
      ),
      child: TextField(
        style: TextStyle(fontSize: 14),
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle:
              TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w400),
        ),
        controller: controller,
        keyboardType:
            isPassword ? TextInputType.text : TextInputType.emailAddress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _inputBox(controller: idController, hintText: '이메일을 입력해주세요'),
        SizedBox(height: 14),
        _inputBox(
            controller: pwController,
            hintText: '비밀번호를 입력해주세요',
            isPassword: true),
        SizedBox(height: 39),
        Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 6),
                blurRadius: 4,
                color: Color.fromRGBO(0, 0, 0, 0.25),
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            color: Color(0xFF222222),
          ),
          child: Text(
            '로그인',
            style: TextStyle(
              color: Color(0xFFF1F1F5),
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }
}

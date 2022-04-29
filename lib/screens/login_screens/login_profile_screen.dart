import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/widgets/login/login_input_text_field.dart';
import 'package:eathub/widgets/login/terms_of_service.dart';
import 'package:eathub/table_pick_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginProfileScreen extends StatefulWidget {
  const LoginProfileScreen({Key? key}) : super(key: key);

  @override
  State<LoginProfileScreen> createState() => _LoginProfileScreenState();
}

class _LoginProfileScreenState extends State<LoginProfileScreen> {
  final nameController = TextEditingController();
  final sexController = TextEditingController();
  final yearController = TextEditingController();

  final controller = Get.put(LoginController());
  final nameFocusNode = FocusNode();
  final sexFocusNode = FocusNode();
  final yearFocusNode = FocusNode();
  var isLoading = false;
  String? nameErrMessage;
  String? sexErrMessage;
  String? yearErrMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    sexFocusNode.dispose();
    yearFocusNode.dispose();

    nameController.dispose();
    sexController.dispose();
    yearController.dispose();
    super.dispose();
  }

  void _nextButtonCallback() async {
    // 여기서 확인 쫙 하자.
    final name = nameController.text;
    final sex = sexController.text;
    final year = yearController.text;

    // 닉네임 체크
    final isValidName = await AuthMethods().isNameOverlaped(name);
    if (name.length == 0) {
      setState(() {
        nameErrMessage = '이름을 입력해 주세요.';
      });
    } else if (isValidName) {
      setState(() {
        nameErrMessage = null;
      });
    } else {
      setState(() {
        nameErrMessage = '이미 사용중입니다.';
      });
    }
    // 성별 체크
    if (!(sex == '남자' || sex == '여자')) {
      setState(() {
        sexErrMessage = '남자 혹은 여자를 입력하세요';
      });
    } else {
      setState(() {
        sexErrMessage = null;
      });
    }
    // 출생연도 체크
    if (year.length == 4) {
      if (year.isNum) {
        setState(() {
          yearErrMessage = null;
        });
      } else {
        setState(() {
          yearErrMessage = '출생연도를 입력하세요.';
        });
      }
    } else {
      setState(() {
        yearErrMessage = '출생연도를 입력하세요.';
      });
    }

    // profile 확인
    if (nameErrMessage == null &&
        sexErrMessage == null &&
        yearErrMessage == null) {
      controller.updateProfile(
          name: name,
          isMale: sex == '남자' ? true : false,
          yearOfBirth: Timestamp.fromDate(DateTime(int.parse(year))));
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return TermsOfServiceSheet();
          });
    }
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
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 28),
                Text(
                  '프로필 설정',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 40),
                Text(
                  '닉네임',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                LoginInputTextField(
                  focusNode: nameFocusNode,
                  controller: nameController,
                  errText: nameErrMessage,
                ),
                SizedBox(height: 40),
                Text(
                  '성별',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                LoginInputTextField(
                  focusNode: sexFocusNode,
                  controller: sexController,
                  errText: sexErrMessage,
                ),
                SizedBox(height: 40),
                Text(
                  '출생연도',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                LoginInputTextField(
                  focusNode: yearFocusNode,
                  controller: yearController,
                  errText: yearErrMessage,
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

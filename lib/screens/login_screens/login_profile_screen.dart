import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/widgets/etc/get_back_icon_button.dart';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/widgets/login/choose_sex_button.dart';
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
  final yearController = TextEditingController();

  final controller = Get.put(LoginController());
  final nameFocusNode = FocusNode();
  final yearFocusNode = FocusNode();

  bool isMale = false;
  var isLoading = false;
  String? nameErrMessage;
  String? yearErrMessage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    yearFocusNode.dispose();

    nameController.dispose();
    yearController.dispose();
    super.dispose();
  }

  _setMale(bool male) {
    isMale = male;
    setState(() {});
  }

  void _nextButtonCallback() async {
    // 여기서 확인 쫙 하자.
    final name = nameController.text;
    final year = yearController.text;

    // 닉네임 체크
    final isValidName = await AuthMethods().isNameOverlaped(name);
    if (name.isEmpty) {
      setState(() {
        nameErrMessage = '닉네임을 입력해 주세요.';
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
    // 출생 연도 체크
    if (year.length == 4) {
      if (year.isNum) {
        setState(() {
          yearErrMessage = null;
        });
      } else {
        setState(() {
          yearErrMessage = '숫자를 입력해주세요.';
        });
      }
    } else {
      setState(() {
        yearErrMessage = '네자리 출생 연도를 입력해주세요.';
      });
    }

    // profile 확인
    if (nameErrMessage == null && yearErrMessage == null) {
      controller.updateProfile(
        name: name,
        isMale: isMale,
        yearOfBirth: Timestamp.fromDate(DateTime(int.parse(year))),
      );
      showModalBottomSheet(
        constraints: BoxConstraints(maxHeight: 450),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        context: context,
        builder: (context) {
          return TermsOfServiceSheet();
        },
      );
    }
  }

  Widget _listTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    );
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
                  '프로필 설정',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 40),
                _listTitle('닉네임'),
                SizedBox(height: 8),
                LoginInputTextField(
                  focusNode: nameFocusNode,
                  controller: nameController,
                  errText: nameErrMessage,
                  hintText: '닉네임을 입력해주세요',
                ),
                SizedBox(height: 40),
                _listTitle('성별'),
                SizedBox(height: 8),
                ChooseSexButton(isMale: isMale, setMale: _setMale),
                SizedBox(height: 40),
                _listTitle('출생 연도'),
                SizedBox(height: 8),
                LoginInputTextField(
                  focusNode: yearFocusNode,
                  controller: yearController,
                  errText: yearErrMessage,
                  hintText: '4자리로 입력해주세요',
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

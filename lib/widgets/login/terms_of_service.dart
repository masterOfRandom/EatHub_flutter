import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/resources/auth_methods.dart';
import 'package:eathub/utils/terms.dart';
import 'package:eathub/table_pick_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfServiceSheet extends StatefulWidget {
  const TermsOfServiceSheet({Key? key}) : super(key: key);

  @override
  State<TermsOfServiceSheet> createState() => _TermsOfServiceSheetState();
}

class _TermsOfServiceSheetState extends State<TermsOfServiceSheet> {
  bool isLoading = false;
  bool isAllChecked = false;
  final controller = Get.put(LoginController());
  final List<bool> isCheckedList = List.filled(terms.length, false);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(children: [
        Text('약관동의'),
        Text('번호 인증을 위해서 개인정보 수집 및 \n이용(필수) 동의가 필요합니다.'),
        SizedBox(height: 66),
        Row(
          children: [
            Checkbox(
                value: isAllChecked,
                onChanged: (isChecked) {
                  if (isChecked != null) {
                    setState(() {
                      isAllChecked = isChecked;
                    });
                    if (isChecked == true) {
                      setState(() {
                        isCheckedList.fillRange(0, isCheckedList.length, true);
                      });
                    }
                  }
                }),
            Text('전체 동의'),
          ],
        ),
        Column(
            children: terms.asMap().entries.map((entrys) {
          final e = entrys.value;
          final i = entrys.key;
          return Row(
            children: [
              Checkbox(
                  value: isCheckedList[i],
                  onChanged: (isChecked) {
                    if (isChecked != null) {
                      setState(() {
                        isCheckedList[i] = isChecked;
                      });
                      if (isChecked == false) {
                        setState(() {
                          isAllChecked = false;
                        });
                      }
                    }
                  }),
              Text(e.title),
              e.isNecessaried ? Text(' (필수)') : Text(' (선택)'),
              Expanded(child: Container()),
              TextButton(
                onPressed: () async {
                  await launch(e.url);
                },
                child: Text('보기'),
              ),
            ],
          );
        }).toList()),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: TablePickElevatedButton(
            text: '다음',
            isLoading: isLoading,
            callback: () async {
              setState(() {
                isLoading = true;
              });
              if (isCheckedList[0] == true &&
                  isCheckedList[1] == true &&
                  isCheckedList[2] == true) {
                final email = controller.email.value;
                final password = controller.password.value;
                final name = controller.name.value;
                final isMale = controller.isMale.value;
                final birthday = controller.yearOfBirth.value;
                final result = await AuthMethods().signUp(
                    email: email,
                    password: password,
                    name: name,
                    favoriteKeyword: ['친절', '깨끗'],
                    birthday: birthday,
                    profileUrl:
                        'https://www.attendit.net/images/easyblog_shared/July_2018/7-4-18/b2ap3_large_totw_network_profile_400.jpg',
                    isMale: isMale);
                if (result == SignState.success) {
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.back();
                } else {
                  Get.snackbar('회원가입에 문제가 발생했습니다.', '고객센터에 문의해주세요.');
                }
              }
              setState(() {
                isLoading = false;
              });
            },
          ),
        ),
      ]),
    );
  }
}

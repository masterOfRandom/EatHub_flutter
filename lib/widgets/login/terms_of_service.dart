import 'package:flutter/material.dart';

class TermsOfServiceSheet extends StatefulWidget {
  const TermsOfServiceSheet({Key? key}) : super(key: key);

  @override
  State<TermsOfServiceSheet> createState() => _TermsOfServiceSheetState();
}

class _TermsOfServiceSheetState extends State<TermsOfServiceSheet> {
  bool isLoading = false;
  bool isCheckedAll = false;
  final List<bool> isCheckedList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text('약관동의'),
        Text('번호 인증을 위해서 개인정보 수집 및 \n이용(필수) 동의가 필요합니다.'),
        Text('전체동의')
      ]),
    );
  }
}

import 'package:flutter/material.dart';

class Term {
  final String title;
  final String url;
  final bool isNecessaried;

  const Term(
      {required this.title, required this.url, required this.isNecessaried});
}

const List<Term> terms = [
  Term(title: '서비스 이용약관에 동의', url: 'hihi', isNecessaried: true),
  Term(title: '개인정보 수집 및 이용에 동의', url: 'haha', isNecessaried: true),
  Term(title: '[마케팅]개인정보 수집 및 이용 동의', url: 'hoho', isNecessaried: false),
  Term(title: '마케팅 정보 수신', url: 'yoyo', isNecessaried: false),
];

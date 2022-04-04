import 'package:flutter/material.dart';

class SignUpAndFindIdPw extends StatelessWidget {
  const SignUpAndFindIdPw({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () => print('회원가입'),
          child: Text(
            '회원가입',
            style: TextStyle(color: Color(0xFF797979)),
          ),
        ),
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 12),
          child: GestureDetector(
            onTap: () => print('아이디 찾기'),
            child: Text(
              '아이디 찾기',
              style: TextStyle(color: Color(0xFF797979)),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => print('비밀번호 찾기'),
          child: Text(
            '비밀번호 찾기',
            style: TextStyle(color: Color(0xFF797979)),
          ),
        )
      ],
    );
  }
}

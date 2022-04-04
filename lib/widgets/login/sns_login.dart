import 'package:flutter/material.dart';

class SnsLogin extends StatelessWidget {
  const SnsLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'SNS계정으로 로그인',
            style: TextStyle(
              color: Color(0xFF797979),
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFC4C4C4),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFC4C4C4),
                ),
              ),
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFC4C4C4),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

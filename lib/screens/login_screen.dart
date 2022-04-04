import 'package:eathub/utils/colors.dart';
import 'package:eathub/widgets/login/login_input_form.dart';
import 'package:eathub/widgets/login/sign_up_and_find_id_pw.dart';
import 'package:eathub/widgets/login/sns_login.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 46),
                Image.asset('assets/eathub_title_logo_without_icon.png'),
                SizedBox(height: 32),
                LoginInputForm(),
                SizedBox(height: 25),
                SignUpAndFindIdPw(),
                SizedBox(height: 49),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.5,
                    )),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: Color(0xFFB7B7B7),
                          ),
                        )),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 45),
                SnsLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

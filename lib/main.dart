import 'package:eathub/env.dart';
import 'package:eathub/screens/layout_screens/mobile_layout_screen.dart';
import 'package:eathub/screens/login_screens/onboard_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_version/new_version.dart';

void main() async {
  // version setting
  NewVersion(iOSAppStoreCountry: 'KR');
  // firebase init 전 widget binding
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.black,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
            shape: CircleBorder(),
            fillColor: MaterialStateColor.resolveWith((states) {
              return primaryRedColor;
            })),
        fontFamily: 'NotoSans',
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: backgroundWhiteColor)),
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        final user = FirebaseAuth.instance.currentUser;
        final connectionState = snapshot.connectionState;
        if (connectionState == ConnectionState.active) {
          if (snapshot.hasData && user != null) {
            return const MobileLayoutScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
        } else if (connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: primaryRedColor));
        }
        return MultiLoginScreen();
      },
    );
  }
}

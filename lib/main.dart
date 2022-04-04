import 'package:eathub/screens/login_screen.dart';
import 'package:eathub/screens/mobile_layout_screen.dart';
import 'package:eathub/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  // firebase init 전 widget binding
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    // getPages: [
    //   GetPage(
    //     name: '/myApp',
    //     page: () => MyApp(),
    //   ),
    //   GetPage(
    //     name: '/signUp',
    //     page: () => SignUpScreen(),
    //   ),
    //   GetPage(
    //     name: '/signIn',
    //     page: () => LoginScreen(),
    //   ),
    // ],
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
        print('여기는 메인이다. 로그인, 로그아웃 등의 이벤트를 다 잡아야한다.');
        final user = FirebaseAuth.instance.currentUser;
        final connectionState = snapshot.connectionState;
        if (connectionState == ConnectionState.active) {
          if (snapshot.hasData && user != null && user.emailVerified) {
            return const MobileLayoutScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
        } else if (connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return const LoginScreen();
      },
    );
  }
}

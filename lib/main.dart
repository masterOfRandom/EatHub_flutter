import 'package:eathub/screens/mobile_layout_screen.dart';
import 'package:eathub/screens/multi_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  // firebase init 전 widget binding
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(
    theme: ThemeData(fontFamily: 'NotoSans'),
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
          return const Center(child: CircularProgressIndicator());
        }
        return MultiLoginScreen();
      },
    );
  }
}

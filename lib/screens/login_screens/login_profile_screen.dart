import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginProfileScreen extends StatefulWidget {
  const LoginProfileScreen({Key? key}) : super(key: key);

  @override
  State<LoginProfileScreen> createState() => _LoginProfileScreenState();
}

class _LoginProfileScreenState extends State<LoginProfileScreen> {
  final nameController = TextEditingController();
  final controller = Get.put(LoginController());
  var isLoading = false;
  var isMale = true;
  var year = DateTime(1994);

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('프로필을 입력하세요.'),
        ),
        body: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: "닉네임을 입력하세요."),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = true;
                      });
                    },
                    child: Container(
                      height: 32,
                      width: 120,
                      color: isMale ? Colors.blue : Colors.white,
                      child: Text('male'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isMale = false;
                      });
                    },
                    child: Container(
                      height: 32,
                      width: 120,
                      color: isMale ? Colors.white : Colors.blue,
                      child: Text('female'),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: YearPicker(
                    firstDate: DateTime(1900),
                    lastDate: DateTime(DateTime.now().year),
                    selectedDate: year,
                    onChanged: (year) {
                      this.year = year;
                    }),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  // showModal
                  controller.updateProfile(
                      name: nameController.text,
                      sex: isMale ? Sex.male : Sex.female,
                      yearOfBirth: Timestamp.fromDate(year));
                  setState(() {
                    isLoading = false;
                  });
                },
                child: Text('다음'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

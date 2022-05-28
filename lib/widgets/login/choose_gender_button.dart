import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';

class ChooseGenderButton extends StatelessWidget {
  final Gender gender;
  final Function(Gender gender) setGender;
  const ChooseGenderButton(
      {Key? key, required this.gender, required this.setGender})
      : super(key: key);

  Widget _genderContainer(String title, bool isChecked) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
      decoration: isChecked
          ? BoxDecoration(
              color: primaryRedColor,
              borderRadius: BorderRadius.circular(10),
            )
          : BoxDecoration(
              color: backgroundWhiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: grayScaleGray4)),
      alignment: Alignment.center,
      child: Text(
        title,
        style:
            TextStyle(color: isChecked ? backgroundWhiteColor : grayScaleGray4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    setGender(Gender.female);
                  },
                  child: _genderContainer('여자', gender == Gender.female)),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    setGender(Gender.male);
                  },
                  child: _genderContainer('남자', gender == Gender.male)),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    setGender(Gender.nothing);
                  },
                  child: _genderContainer('선택안함', gender == Gender.nothing)),
            ),
          ],
        ));
  }
}

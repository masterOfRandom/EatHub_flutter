import 'package:eathub/utils/colors.dart';
import 'package:flutter/material.dart';

class ChooseSexButton extends StatelessWidget {
  final bool isMale;
  final Function(bool isMale) setMale;
  const ChooseSexButton({Key? key, required this.isMale, required this.setMale})
      : super(key: key);

  Widget _sexContainer(String title, bool isChecked) {
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
    return Container(
        width: double.infinity,
        height: 50,
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    setMale(false);
                  },
                  child: _sexContainer('여자', !isMale)),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    setMale(true);
                  },
                  child: _sexContainer('남자', isMale)),
            ),
          ],
        ));
  }
}

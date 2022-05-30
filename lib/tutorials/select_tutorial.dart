import 'dart:math';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/widgets/tutorial/hand_animation.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:flutter/material.dart';

class SelectCardScreenTutorial {
  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  final BuildContext context;
  final GlobalKey foodCard;
  final GlobalKey likeNopeButton;
  var rotateAngle = 45.0 / 180 * pi;

  SelectCardScreenTutorial(
      {required this.context,
      required this.foodCard,
      required this.likeNopeButton});

  void showTutorial() {
    initTargets();
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.black,
      skipWidget: const Icon(
        Icons.close,
        color: grayScaleGray4,
      ),
      paddingFocus: 10,
      opacityShadow: 0.9,
    )..show();
    rotateAngle = 45 / 180 * pi;
  }

  void initTargets() {
    rotateAngle = 0;
    targets.clear();
    targets.add(
      TargetFocus(
        identify: "foodCard",
        keyTarget: foodCard,
        alignSkip: Alignment.topRight,
        radius: 20,
        contents: [
          TargetContent(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "카드를 오른쪽으로 스와이프하면\nLIKE PICK!!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "LIKE PICK은 '좋아요한 페이지'에서 확인 할 수 있어요!",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              );
            },
          ),
          TargetContent(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  RotateAnimationLoopImage(
                    durationMilliseconds: 1000,
                    startPosition: -100,
                    endPosition: 100,
                    movedAngle: 45 / 360,
                    startAngle: 0.0,
                    imageHeight: 100.0,
                    imageWidth: 100.0,
                  ),
                ],
              );
            },
          ),
        ],
        shape: ShapeLightFocus.RRect,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "foodCard2",
        keyTarget: foodCard,
        alignSkip: Alignment.topRight,
        radius: 20,
        contents: [
          TargetContent(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    "카드를 왼쪽으로 스와이프하면\nYET PICK !!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "YET PICK은 홈 화면에 3일 후에 다시 떠요!",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              );
            },
          ),
          TargetContent(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  RotateAnimationLoopImage(
                    durationMilliseconds: 1000,
                    startPosition: 100,
                    endPosition: -100,
                    movedAngle: -45 / 360,
                    startAngle: 0.0,
                    imageHeight: 100.0,
                    imageWidth: 100.0,
                  ),
                ],
              );
            },
          ),
        ],
        shape: ShapeLightFocus.RRect,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "likeNopeButton",
        keyTarget: likeNopeButton,
        alignSkip: Alignment.topRight,
        radius: 20,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "버튼을 탭해도 PICK이 되어요!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
        shape: ShapeLightFocus.RRect,
      ),
    );
    targets.add(
      TargetFocus(
        identify: "foodCard3",
        keyTarget: foodCard,
        alignSkip: Alignment.topRight,
        radius: 20,
        contents: [
          TargetContent(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "푸드카드를 눌러보세요!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    "내 근처에서 이 메뉴를\n판매하는 식당이 뜰거예요",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              );
            },
          ),
        ],
        shape: ShapeLightFocus.RRect,
      ),
    );
  }
}

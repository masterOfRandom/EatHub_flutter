import 'dart:math';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/models/food.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_style.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:eathub/widgets/select_card/brief_description.dart';
import 'package:eathub/widgets/like_nope_yet_checker.dart';
import 'package:eathub/widgets/select_card/recommand_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectCardScreen extends StatefulWidget {
  const SelectCardScreen({Key? key}) : super(key: key);

  @override
  State<SelectCardScreen> createState() => _SelectCardScreenState();
}

class _SelectCardScreenState extends State<SelectCardScreen> {
  final controller = Get.put(GController());

  @override
  void initState() {
    super.initState();
    controller.addFoods();
  }

  Widget buildCards() {
    return Obx(() {
      final foods = controller.foods;
      return foods.isEmpty
          ? Center(
              child: Text(
                '더이상 음식이 없습니다... 모든 음식을 다 보셨군요??',
                style: TextStyle(fontSize: 32),
              ),
            )
          : Stack(
              children: foods
                  .map((food) => FoodCard(
                        food: food,
                        isFront: foods.last == food,
                      ))
                  .toList(),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLightPinkColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 8),
              RecommandText(text: '오늘은 이 메뉴 어때요?'),
              SizedBox(height: 16),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: buildCards(),
                ),
              ),
              SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: secondaryPinkColor,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 10,
                            color: secondaryPinkColor.withOpacity(0.15)),
                      ],
                    ),
                    child: Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    margin: EdgeInsets.symmetric(horizontal: 28),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 10,
                            color: secondaryPinkGrayColor.withOpacity(0.15)),
                      ],
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: Color(0xFF630000),
                    ),
                  ),
                  Container(
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryRedColor,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 10,
                            color: primaryRedColor.withOpacity(0.15)),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodCard extends StatefulWidget {
  final Food food;
  final bool isFront;

  const FoodCard({
    Key? key,
    required this.food,
    required this.isFront,
  }) : super(key: key);

  @override
  State<FoodCard> createState() => FoodCardState();
}

class FoodCardState extends State<FoodCard> {
  final controller = Get.put(GController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final size = MediaQuery.of(context).size;

      controller.setScreenSize(size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: widget.isFront ? buildFrontCard() : buildCard(false),
    );
  }

  Widget buildFrontCard() {
    return GestureDetector(child: LayoutBuilder(builder: (context, constrains) {
      return Obx(() {
        final milliseconds =
            controller.isDragging.value ? 0 : cardReturnMillisecond;
        final position = controller.position.value;

        final center = constrains.smallest.center(Offset.zero);
        final angle = controller.angle.value * pi / 180;
        final rotatedMatrix = Matrix4.identity()
          ..translate(center.dx, center.dy)
          ..rotateZ(angle)
          ..translate(-center.dx, -center.dy);
        final resultMatrix = rotatedMatrix..translate(position.dx, position.dy);

        return AnimatedContainer(
          curve: Curves.easeInOut,
          transform: resultMatrix,
          duration: Duration(milliseconds: milliseconds),
          child: buildCard(true),
        );
      });
    }), onPanStart: (details) {
      controller.startPosition(details);
    }, onPanUpdate: (details) {
      controller.updatePosition(details);
    }, onPanEnd: (details) {
      controller.endPosition();
    }, onTap: () {
      print('tap!');
    });
  }

  Widget buildCard(bool isFront) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: cardRadius),
                  image: DecorationImage(
                    image: NetworkImage(widget.food.imageUrl == null
                        ? defaultFoodImageUrl
                        : widget.food.imageUrl!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              isFront ? const LikeNopeYetChecker() : Container(),
            ],
          ),
        ),
        BriefDescription(
          name: widget.food.name == null ? '이름이 없습니다.' : widget.food.name!,
          keyword:
              widget.food.flavors == null ? ['nothing'] : widget.food.flavors!,
        ),
      ],
    );
  }
}

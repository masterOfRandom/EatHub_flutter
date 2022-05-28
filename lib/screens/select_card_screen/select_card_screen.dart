import 'dart:math';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/models/food.dart';
import 'package:eathub/presentation/table_pick_icons.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_style.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:eathub/screens/restaurant_list_screens/restaurant_list_screen.dart';
import 'package:eathub/widgets/select_card/brief_description.dart';
import 'package:eathub/widgets/like_nope_yet_checker.dart';
import 'package:eathub/widgets/select_card/empty_card.dart';
import 'package:eathub/widgets/select_card/recommand_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class SelectCardScreen extends StatefulWidget {
  const SelectCardScreen({Key? key}) : super(key: key);

  @override
  State<SelectCardScreen> createState() => _SelectCardScreenState();
}

class _SelectCardScreenState extends State<SelectCardScreen> {
  final controller = Get.put(GController());
  bool isPressedYet = false;
  bool isPressedLike = false;
  bool isPressedNope = false;

  @override
  void initState() {
    super.initState();
    if (controller.foods.length < 3) {
      controller.addFoods();
    }
  }

  Widget buildCards() {
    return Obx(() {
      final foods = controller.foods;

      return foods.isEmpty
          ? const EmptyCard()
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundWhiteColor,
        title: const Text(
          'Tablepick',
          style: mainTitleTextStyle,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Obx(() {
                return RecommandText(
                    text: '오늘은\n이 메뉴 어때요? 🤤',
                    isVisible: controller.foods.isNotEmpty);
              }),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: buildCards(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTapDown: (detail) {
                      isPressedNope = true;
                      setState(() {});
                    },
                    onTapCancel: () {
                      isPressedNope = false;
                      setState(() {});
                    },
                    onTapUp: (detail) {
                      isPressedNope = false;
                      setState(() {});
                    },
                    onTap: () async {
                      controller.statusPoint.value = 200;
                      controller.status.value = CardStatus.nope;
                      await Future.delayed(const Duration(milliseconds: 150));
                      controller.nope();
                    },
                    child: Container(
                      height: 66,
                      width: 66,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: grayScaleGray3,
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 10,
                              color: secondaryPinkColor.withOpacity(0.15)),
                        ],
                      ),
                      child: Icon(
                        isPressedNope ? TablePick.bigx : TablePick.smallx,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTapDown: (detail) {
                      isPressedLike = true;
                      setState(() {});
                    },
                    onTapCancel: () {
                      isPressedLike = false;
                      setState(() {});
                    },
                    onTapUp: (detail) {
                      isPressedLike = false;
                      setState(() {});
                    },
                    onTap: () async {
                      controller.statusPoint.value = 200;
                      controller.status.value = CardStatus.like;
                      await Future.delayed(const Duration(milliseconds: 150));
                      controller.like();
                    },
                    child: Container(
                      height: 66,
                      width: 66,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryRedColor,
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 10),
                              blurRadius: 10,
                              color: primaryRedColor.withOpacity(0.15)),
                        ],
                      ),
                      child: Icon(
                        isPressedLike
                            ? TablePick.bigHeart
                            : TablePick.smallHeart,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
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
    return GestureDetector(
      child: LayoutBuilder(builder: (context, constrains) {
        return Obx(() {
          final isDragging = controller.isDragging.value;
          final milliseconds = isDragging ? 0 : cardReturnMillisecond;
          final position = controller.position.value;
          final angle = controller.angle.value * pi / 180;
          final rotatedMatrix = isDragging
              ? (Matrix4.identity()
                ..rotateZ(angle)
                ..scale(1.05))
              : Matrix4.identity()
            ..rotateZ(angle);
          final resultMatrix = rotatedMatrix
            ..translate(position.dx, position.dy);

          return AnimatedContainer(
            curve: Curves.easeInOut,
            transformAlignment: FractionalOffset.center,
            transform: resultMatrix,
            duration: Duration(milliseconds: milliseconds),
            child: buildCard(true),
          );
        });
      }),
      onTapDown: (details) {
        controller.isDragging.value = true;
      },
      onTapUp: (details) {
        controller.isDragging.value = false;
      },
      onPanStart: (details) {
        controller.startPosition(details);
      },
      onPanUpdate: (details) {
        controller.updatePosition(details);
      },
      onPanEnd: (details) {
        controller.endPosition();
      },
      onTap: () {
        Get.to(RestaurantListScreen(
          foodName: controller.foods.last.name!,
        ));
      },
    );
  }

  Widget buildCard(bool isFront) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(cardRadius),
                child: Stack(children: [
                  FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.food.imageUrl == null
                        ? defaultFoodImageUrl
                        : widget.food.imageUrl!,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: const Alignment(0, 1),
                        end: const Alignment(0, 0.3),
                        colors: [
                          Colors.black.withOpacity(1),
                          Colors.black.withOpacity(0),
                          Colors.white.withOpacity(0),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      child: Text(
                        widget.food.name!,
                        style: const TextStyle(
                          color: backgroundWhiteColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              isFront ? const LikeNopeYetChecker() : Container(),
            ],
          ),
        ),
      ],
    );
  }
}

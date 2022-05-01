import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:lottie/lottie.dart';

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
    if (controller.foods.length < 3) {
      controller.addFoods();
    }
  }

  Widget buildCards() {
    return Obx(() {
      final foods = controller.foods;
      return foods.isEmpty
          ? EmptyCard()
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
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Obx(() {
                return RecommandText(
                    text: '오늘은 이 메뉴 어때요?',
                    isVisible: controller.foods.isNotEmpty);
              }),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: buildCards(),
                ),
              ),
              const SizedBox(height: 36),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      controller.statusPoint.value = 200;
                      controller.status.value = CardStatus.yet;
                      await Future.delayed(Duration(milliseconds: 150));
                      controller.yet();
                    },
                    child: Container(
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
                        TablePick.smallYet,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      controller.statusPoint.value = 200;
                      controller.status.value = CardStatus.nope;
                      await Future.delayed(Duration(milliseconds: 150));
                      controller.nope();
                    },
                    child: Container(
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
                        TablePick.smallx,
                        color: Color(0xFF630000),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      controller.statusPoint.value = 200;
                      controller.status.value = CardStatus.like;
                      await Future.delayed(Duration(milliseconds: 150));
                      controller.like();
                    },
                    child: Container(
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
                        TablePick.smallHeart,
                        color: Colors.white,
                        size: 42,
                      ),
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
      Get.to(RestaurantListScreen(
        foodName: controller.foods.last.name!,
      ));
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
                    image: CachedNetworkImageProvider(
                        widget.food.imageUrl == null
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

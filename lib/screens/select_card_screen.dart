import 'dart:math';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_style.dart';
import 'package:eathub/utils/global_var.dart';
import 'package:eathub/widgets/brief_description.dart';
import 'package:eathub/widgets/like_nope_yet_checker.dart';
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
    controller.resetUsers();
  }

  Widget buildCards() {
    return Obx(() {
      final imageUrls = controller.imageUrls;
      return imageUrls.isEmpty
          ? Center(
              child: ElevatedButton(
                child: const Text('RESET'),
                onPressed: () => controller.resetUsers(),
              ),
            )
          : Stack(
              children: imageUrls
                  .map((element) => TinderCard(
                        urlImage: element,
                        isFront: imageUrls.last == element,
                      ))
                  .toList(),
            );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 8, top: 8, right: 8),
                child: buildCards(),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFC25858),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 10,
                            color: Color.fromARGB(51, 85, 85, 85))
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
                            color: Color.fromARGB(51, 85, 85, 85))
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
                      color: secondaryColor,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 10,
                            color: Color.fromARGB(51, 85, 85, 85))
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
            )
          ],
        ),
      ),
    );
  }
}

class TinderCard extends StatefulWidget {
  final String urlImage;
  final bool isFront;

  const TinderCard({
    Key? key,
    required this.urlImage,
    required this.isFront,
  }) : super(key: key);

  @override
  State<TinderCard> createState() => _TinderCardState();
}

class _TinderCardState extends State<TinderCard> {
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
    return GestureDetector(
      child: LayoutBuilder(builder: (context, constrains) {
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
          final resultMatrix = rotatedMatrix
            ..translate(position.dx, position.dy);

          return AnimatedContainer(
            curve: Curves.easeInOut,
            transform: resultMatrix,
            duration: Duration(milliseconds: milliseconds),
            child: buildCard(true),
          );
        });
      }),
      onPanStart: (details) {
        controller.startPosition(details);
      },
      onPanUpdate: (details) {
        controller.updatePosition(details);
      },
      onPanEnd: (details) {
        controller.endPosition();
      },
    );
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
                    image: NetworkImage(widget.urlImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              isFront ? const LikeNopeYetChecker() : Container(),
            ],
          ),
        ),
        const BriefDescription(
          name: '리애',
          address: '서울 강남구 선릉로 16길 6',
          menu: '로스(등심)까스, 히레(안심)까스, 프리미엄 로스(등심)',
          rating: 4.24,
        ),
      ],
    );
  }
}

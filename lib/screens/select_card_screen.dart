import 'dart:math';
import 'package:eathub/getx/getx_controller.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/utils/global_var.dart';
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
                padding: EdgeInsets.all(16),
                child: buildCards(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(
                    Icons.close_rounded,
                    color: Color(0xFF630000),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 44,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 30,
                  child: Icon(
                    Icons.star,
                    color: Color(0xFF630000),
                  ),
                ),
              ],
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
    return Container(
      child: widget.isFront ? buildFrontCard() : buildCard(),
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
            child: buildCard(),
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

  Widget buildCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        image: DecorationImage(
          image: NetworkImage(widget.urlImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

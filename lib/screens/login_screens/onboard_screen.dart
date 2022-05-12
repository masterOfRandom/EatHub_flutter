import 'package:carousel_slider/carousel_slider.dart';
import 'package:eathub/screens/login_screens/login_email_screen.dart';
import 'package:eathub/utils/colors.dart';
import 'package:eathub/widgets/login/onboard_standard_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class MultiLoginScreen extends StatefulWidget {
  const MultiLoginScreen({Key? key}) : super(key: key);

  @override
  State<MultiLoginScreen> createState() => _MultiLoginScreenState();
}

class _MultiLoginScreenState extends State<MultiLoginScreen> {
  final carouselController = CarouselController();
  int checkedPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  void _nextPage() {
    carouselController.nextPage(curve: Curves.ease);
  }

  List<Widget> _items() {
    return [
      OnboardStandardForm(
        imageWidget: Lottie.asset(
          'assets/lotties/onboard_first_page.json',
          frameRate: FrameRate(60),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('안녕하세요,',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Tablepick',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                    fontFamily: 'Baloo2',
                    color: primaryRedColor,
                  )),
              Text('입니다.',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  )),
            ],
          )
        ]),
        descript: '오늘도 뭐 먹을지 고민되시나요?\n랜덤으로 메뉴를 추천해드립니다!',
        callback: _nextPage,
        buttonText: '다음',
      ),
      OnboardStandardForm(
        imageWidget: SvgPicture.asset('assets/images/onboard_second_page.svg'),
        title: const Text('메뉴 카드를 넘겨보세요',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
        descript: '마음에 드시는 메뉴를 픽해보세요\n버튼을 눌러도 선택됩니다',
        callback: _nextPage,
        buttonText: '다음',
      ),
      OnboardStandardForm(
        imageWidget: SvgPicture.asset('assets/images/onboard_third_page.svg'),
        title: const Text('마이픽을 확인해보세요',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
        descript: '선택된 LIKE와 NOPE은\n마이픽에서 확인할 수 있어요',
        callback: _nextPage,
        buttonText: '다음',
      ),
      OnboardStandardForm(
        imageWidget: SvgPicture.asset('assets/images/onboard_fourth_page.svg'),
        title: const Text('원하시는 메뉴가 이곳에',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
        descript: '고르신 메뉴가 마음에 드셨나요?\n가까운 이곳은 어떠세요?',
        callback: () => Get.to(const LoginEmailScreen()),
        buttonText: '이메일로 시작하기',
      ),
    ];
  }

  Widget oneIndicator(bool isChecked) {
    return AnimatedContainer(
      height: 8,
      width: isChecked ? 16 : 8,
      duration: const Duration(milliseconds: 200),
      decoration: isChecked
          ? BoxDecoration(
              color: primaryRedColor,
              borderRadius: BorderRadius.circular(4),
            )
          : BoxDecoration(
              color: grayScaleGray4,
              borderRadius: BorderRadius.circular(4),
            ),
    );
  }

  Widget _indicator(int index) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          oneIndicator(index == 0),
          const SizedBox(width: 8),
          oneIndicator(index == 1),
          const SizedBox(width: 8),
          oneIndicator(index == 2),
          const SizedBox(width: 8),
          oneIndicator(index == 3),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backgroundWhiteColor,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      height: double.infinity,
                      onPageChanged: (i, _) {
                        checkedPageIndex = i;
                        setState(() {});
                      }),
                  items: _items(),
                ),
              ),
              Positioned(
                child: _indicator(checkedPageIndex),
              )
            ],
          ),
        ),
      ),
    );
  }
}

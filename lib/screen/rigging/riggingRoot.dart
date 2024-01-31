import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:projectfront/widget/design/basicButtons.dart';
import 'drawSkeleton.dart';
import '../../widget/design/settingColor.dart';
import '../gree/favoriteList.dart';
import '../gree/keepItem.dart';
import '../../widget/addFavorite.dart';


class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int activeIndex = 0;

  final List<String> imagePaths = [
    'assets/images/gree.png',
    'assets/images/greegirl_3.png',
    'assets/images/gree_2.png',
    //'assets/images/greegirl.png',
    //'assets/images/greegirl_2.png',

  ];



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        color: colorMainBG_greedot,
        child: Stack(
          children: <Widget>[
            CarouselSlider(
              items: imagePaths.map((path) {
                int index = imagePaths.indexOf(path);
                return Builder(
                  builder: (BuildContext context) {
                    return FlipCard(
                      front: Image.asset(path, fit: BoxFit.cover),
                      back: buildCardBack(favoriteItems[index]),
                    );
                  },
                );
              }).toList(),

              options: CarouselOptions(
                height: 240,
                viewportFraction: 1.0,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
            Positioned(
              bottom: 270,
              left: 0,
              right: 0,
              child: Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: imagePaths.length,
                  effect: SlideEffect(
                    dotHeight: 6,
                    dotWidth: 6,
                    dotColor: Colors.black26,
                    activeDotColor: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 230,
              left: 0,
              right: 0,
              child: Text(
                  "캐릴터를 터치하면 캐릭터 정보가 보여요!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorSnackBar_greedot, fontSize: 15)
              ),
            ),
            Positioned(
              bottom: 50,
              left: 0,
              right: 170,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 35),
                  Big_EleButton_greedot(
                    gotoScene: () => FavoriteListPage(),
                    buttonText: "AI 친구들 모아보기",
                  ),
                  const SizedBox(height: 15),
                  Big_EleButton_greedot(
                    gotoScene: () => SkeletonCanvas(),
                    buttonText: "우리아이 대화 보기",
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 170,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 35),
                  Big_EleButton_greedot(
                    gotoScene: () => SkeletonCanvas(),
                    buttonText: "새 AI 친구 만들기",
                  ),
                  const SizedBox(height: 15),
                  Big_EleButton_greedot(
                    gotoScene: () => SkeletonCanvas(),
                    buttonText: "같이 게임하기(?)",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildCardBack(FavoriteItemCard item) {
  return buildItemTextSection(item);
}

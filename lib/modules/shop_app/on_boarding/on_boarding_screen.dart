import 'package:flutter/material.dart';
import 'package:flutter_project/modules/shop_app/shop_app_login/shop_login_screen.dart';
import 'package:flutter_project/shared/network/local/cache_helper.dart';
import 'package:flutter_project/shared/styles/colors/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../shared/components/components.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoarding> boarding = [
    OnBoarding(
        image: "assets/images/on_boarding.png",
        title: "On Board 1 Title",
        body: "On Board 1 Body"),
    OnBoarding(
        image: "assets/images/on_boarding.png",
        title: "On Board 2 Title",
        body: "On Board 2 Body"),
    OnBoarding(
        image: "assets/images/on_boarding.png",
        title: "On Board 3 Title",
        body: "On Board 3 Body"),
  ];

  var pageController = PageController();
  bool isLast = false;
  void onBoarding(){
    CacheHelper.saveData(key: 'onBoarding', value: true,).then((value){
      if(value){
        navigateFinish(context, ShopLoginScreen());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defalutTextButton(
        text: 'Skip',
        function: onBoarding
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => boardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                      activeDotColor: primarycolor,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4.0,
                      spacing: 5.0),
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: primarycolor,
                  onPressed: () {
                    if(isLast){
                      onBoarding();
                    }else {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }

                  },
                  child: const Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
            SizedBox(height: 30.0,)
          ],
        ),
      ),
    );
  }
}

Widget boardingItem(OnBoarding model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage("${model.image}"),
          ),
        ),
        const SizedBox(height: 30.0),
        Text(
          '${model.title}',
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15.0),
        Text(
          '${model.body}',
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );

class OnBoarding {
  String image;
  String title;
  String body;
  OnBoarding({required this.image, required this.title, required this.body});
}

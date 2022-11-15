import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoffee/screen/login/login_screen.dart';
import 'package:scoffee/screen/onboarding/onboarding_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
        init: OnboardingController(),
        builder: (controller) {
          var height = Get.height;
          var width = Get.width;
          return Scaffold(
            backgroundColor: const Color(0xFFBF8E2C),
            body: Container(
              margin: EdgeInsets.only(
                top: height * 0.06,
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 4,
                    child: PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: controller.pageController,
                      onPageChanged: (int index) {
                        controller.pageController;
                        controller.update();
                      },
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                width: width,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/onboarding/onboarding1.png'),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.bottomRight,
                                padding: const EdgeInsets.only(right: 32.0),
                                width: width,
                                child: const Text(
                                  'Discuss',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerRight,
                                margin: const EdgeInsets.only(right: 32.0),
                                width: width * 0.7,
                                child: const Text(
                                  'Anda dapat berdiskusi seputar kopi di aplikasi scoffee',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },

                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 15.0,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmoothPageIndicator(
                            controller: controller.pageController,
                            count: 3,
                            onDotClicked: (index) => controller.pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeIn,
                            ),
                            effect: const ExpandingDotsEffect(
                              activeDotColor: Color(0xFF0C3DF3),
                              dotColor: Colors.grey,
                              expansionFactor: 2.5,
                              dotHeight: 14,
                            ),
                          ),
                          Container(
                            height: 45,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                bottomLeft: Radius.circular(8.0),
                              ),
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0C3DF3),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(14.0),
                                    bottomLeft: Radius.circular(14.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                controller.pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeIn,
                                );
                                if (controller.currentPage == 2) {
                                 Get.offAll(() => const LoginScreen());
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.currentPage == 2 ? 'Masuk' : 'Selanjutnya',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}

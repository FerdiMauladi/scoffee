import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scoffee/screen/login/login_screen.dart';
import 'package:scoffee/screen/onboarding/onboarding_controller.dart';
import 'package:scoffee/screen/onboarding/onboarding_one_screen.dart';
import 'package:scoffee/screen/onboarding/onboarding_third_screen.dart';
import 'package:scoffee/screen/onboarding/onboarding_two_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OnboardingController(),
      builder: (controller) {
        var height = Get.width;
        return Scaffold(
          backgroundColor: const Color(0xFF674109),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Color(0xFF674109),
              statusBarIconBrightness: Brightness.light,
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(
              top: height * 0.06,
            ),
            child: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: PageView(
                    physics: const BouncingScrollPhysics(),
                    controller: controller.pageController,
                    onPageChanged: (int index) {
                      controller.currentPage = index;
                      controller.update();
                    },
                    children: const [
                      OnboardingOneScreen(),
                      OnboardingTwoScreen(),
                      OnboardingThirdScreen(),
                    ],
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
                            activeDotColor: Color(0xFFBF8E2C),
                            dotColor: Colors.white,
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
                              backgroundColor: const Color(0xFFBF8E2C),
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
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
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

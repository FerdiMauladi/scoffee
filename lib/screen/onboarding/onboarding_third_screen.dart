import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingThirdScreen extends StatelessWidget {
  const OnboardingThirdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    return Container(
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.center,
              width: width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/onboarding/onboarding3.png'),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: const Text(
                'Coffee',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              width: width,
              child: const Text(
                'Anda dapat melihat cerita-cerita seputar kopi yang ada di sumedang',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

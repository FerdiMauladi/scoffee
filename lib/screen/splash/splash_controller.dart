import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/screen/bottomappbar/bottomappbar.dart';
import 'package:scoffee/screen/onboarding/onboarding_screen.dart';

class SplashController extends BaseController {
  final storageSecure = const FlutterSecureStorage();
  String? token;

  @override
  void onInit() {
    getToken();
    Timer(const Duration(seconds: 3), () async {
      if (token != null && token != '-') {
        Get.offAll(() => const BottomAppBar());
      }
      else {
        Get.offAll(const OnboardingScreen());
      }
    });
    super.onInit();
  }

  void getToken() async {
    token = await storageSecure.read(key: 'token');
    update();
  }
}
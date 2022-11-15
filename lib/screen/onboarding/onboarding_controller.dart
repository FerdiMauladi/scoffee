import 'package:flutter/material.dart';
import 'package:scoffee/base/base_controller.dart';

class OnboardingController extends BaseController {
  var pageController = PageController();
  int? currentPage = 0;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}

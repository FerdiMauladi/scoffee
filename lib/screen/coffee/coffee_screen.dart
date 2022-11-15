import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoffee/screen/coffee/coffee_controller.dart';

class CoffeeScreen extends StatelessWidget {
  const CoffeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoffeeController>(
      init: CoffeeController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Coffee'),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Text(
              'Coffee Screen',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
        );
      }
    );
  }
}

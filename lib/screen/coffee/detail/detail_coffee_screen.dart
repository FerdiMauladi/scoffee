import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoffee/const/app_const.dart';
import 'package:scoffee/screen/coffee/detail/detail_coffee_controller.dart';

class DetailCoffeeScreen extends StatelessWidget {
  const DetailCoffeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailCoffeeController>(
      init: DetailCoffeeController(),
      builder: (controller) {
        if (controller.state == DetailCoffeeViewState.loading) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                'Detail',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: const Color(0xFF362204),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
            body: Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: Color(0xFF362204),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF362204),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
              ),
            ),
            title: const Text(
              'Detail',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            centerTitle: true,
          ),
          backgroundColor: Colors.white,
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                  bottom: 8.0,
                ),
                child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        AppConst.baseImageCoffeeUrl +
                            controller.detailCoffee.image!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.detailCoffee.name!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  controller.detailCoffee.description?.replaceAll('<p>', '').replaceAll('</p>', '') ?? 'error',
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
            ],
          ),
        );
      },
    );
  }
}

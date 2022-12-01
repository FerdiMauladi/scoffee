import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoffee/const/app_const.dart';
import 'package:scoffee/screen/discussion/detail/education/detail_education_controller.dart';
import 'package:scoffee/screen/event/detail/detail_event_controller.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailEducationScreen extends StatelessWidget {
  const DetailEducationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailEducationController>(
      init: DetailEducationController(),
      builder: (controller) {
        if (controller.state == DetailEducationState.loading) {
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
              if (controller.detailEducation.image != null)
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
                        AppConst.baseImageEducationUrl +
                            controller.detailEducation.image!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  controller.detailEducation.title!,
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
                child: Html(
                  data: controller.detailEducation.body ?? 'error',
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

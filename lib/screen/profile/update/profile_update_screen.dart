import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoffee/const/app_const.dart';
import 'package:scoffee/screen/discussion/add/add_discuss_controller.dart';
import 'package:scoffee/screen/profile/update/profile_update_controller.dart';

class ProfileUpdateScreen extends StatelessWidget {
  const ProfileUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileUpdateController>(
      init: ProfileUpdateController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xFF362204),
            title: const Text(
              'Update Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
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
          body: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: controller.formKeyUpdate,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.getSinglePhoto();
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 30.0,
                              ),
                              width: 150,
                              height: 150,
                              alignment: Alignment.center,
                              child: controller.userModel.userDetail!.image != null
                                  ? CircleAvatar(
                                backgroundColor: const Color(0xFF362204),
                                foregroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    AppConst.baseImageProfileUrl +
                                        controller.userModel.userDetail!.image!),
                                maxRadius: 80,
                              )
                                  : const CircleAvatar(
                                backgroundColor: Color(0xFF362204),
                                foregroundColor: Colors.white,
                                backgroundImage: AssetImage(
                                  'assets/images/profile/profile.png',
                                ),
                                maxRadius: 80,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Nama',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: controller.nameController,
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return 'Name cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Masukan nama anda',
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 5,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          const Text(
                            'email',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: controller.emailController,
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              enabled: false,
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return 'Email cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Masukan email anda',
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    width: 5,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35.0,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: Get.width * 0.8,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  final form =
                                      controller.formKeyUpdate.currentState;
                                  if (form!.validate()) {

                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFBF8E2C),
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  alignment: Alignment.center,
                                  elevation: 2,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Posting',
                                  style: TextStyle(
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
            ],
          ),
        );
      },
    );
  }
}

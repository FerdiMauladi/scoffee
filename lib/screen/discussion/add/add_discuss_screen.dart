import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoffee/screen/discussion/add/add_discuss_controller.dart';
import 'package:scoffee/screen/register/register_controller.dart';

class AddDiscussScreen extends StatelessWidget {
  const AddDiscussScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDiscussController>(
      init: AddDiscussController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: const Color(0xFF362204),
            title: const Text(
              'Posting Forum',
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
                    key: controller.formKeyAdd,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Image Forum',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.getSinglePhoto();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 200,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.brown,
                                  width: 2,
                                ),
                              ),
                              child: controller.pathFoto != null
                                  ? Image.file(
                                      controller.pathFoto!,
                                      fit: BoxFit.fill,
                                    )
                                  : const Center(
                                      child: Text('upload photo'),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: controller.titleController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return 'Title cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Masukan judul forum',
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
                            'Content',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              cursorColor: Colors.black,
                              controller: controller.contentController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              minLines: 4,
                              maxLines: 6,
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return 'Content cannot be empty';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Masukan konten forum',
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
                                      controller.formKeyAdd.currentState;
                                  if (form!.validate()) {
                                    controller.postForum();
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


import 'dart:io';

import 'package:flutter/material.dart' hide BottomAppBar;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/screen/bottomappbar/bottomappbar.dart';
import 'package:scoffee/screen/discussion/discuss/discuss_screen.dart';

class AddDiscussController extends BaseController {
  File? pathFoto;
  var id = Get.arguments;

  final formKeyAdd = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void onInit() {
    print(id['id']);
    super.onInit();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  getSinglePhoto() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      pathFoto = file;
      update();
    } else {

    }
  }

  void postForum () async {
    var response = await repository.postForum(categoryId: id['id'], title: titleController.text, description: contentController.text);
    if (response.statusCode == 201) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Posting berhasil di upload',
          isDismissible: true,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      Get.offAll(() => const BottomAppBar());
    }
  }

}
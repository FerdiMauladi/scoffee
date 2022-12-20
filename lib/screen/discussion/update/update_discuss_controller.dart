
import 'dart:io';

import 'package:flutter/material.dart' hide BottomAppBar;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/data/model/detail_discuss_model.dart';
import 'package:scoffee/screen/bottomappbar/bottomappbar.dart';
import 'package:scoffee/screen/discussion/discuss/discuss_screen.dart';

enum DetailDiscussViewState {
  none,
  loading,
  error,
}

class UpdateDiscussController extends BaseController {
  DetailDiscussViewState _state = DetailDiscussViewState.none;

  DetailDiscussViewState get state => _state;
  File? pathFoto;
  DetailDiscussModel detailDiscuss = DetailDiscussModel();
  DetailDiscussModel detailForums = DetailDiscussModel();
  var id = Get.arguments;

  final formKeyAdd = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();


  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  changeState(DetailDiscussViewState s) {
    _state = s;
    update();
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

  Future fetchData() async {
    changeState(DetailDiscussViewState.loading);
    try {
      final detailComment = await repository.getForum(id: id['id']);
      detailForums = detailComment!;
      contentController.text = detailForums.forums!.description!;
      changeState(DetailDiscussViewState.none);
    } catch (e) {
      changeState(DetailDiscussViewState.error);
    }
  }

  void postForum () async {
    var response = await repository.postForum(categoryId: id['id'], title: titleController.text, description: contentController.text, image: pathFoto);
    if (response.statusCode == 201) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Posting berhasil di update',
          isDismissible: true,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ),
      );
      Get.off(() => const BottomAppBar());
    }
  }

}
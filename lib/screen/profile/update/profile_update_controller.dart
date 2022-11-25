
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/data/model/user_model.dart';

enum ProfileViewState {
  none,
  loading,
  error,
}

class ProfileUpdateController extends BaseController {
  final storageSecure = const FlutterSecureStorage();
  UserModel userModel = UserModel();
  File? pathFoto;
  ProfileViewState _state = ProfileViewState.none;
  ProfileViewState get state => _state;

  final formKeyUpdate = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final descriptionController = TextEditingController();
  final lastEducationController = TextEditingController();
  final workController = TextEditingController();

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    descriptionController.dispose();
    lastEducationController.dispose();
    workController.dispose();
    super.dispose();
  }

  changeState(ProfileViewState s) {
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

  Future getUser() async {
    changeState(ProfileViewState.loading);
    try {
      var data = await repository.getDataUser();
      userModel = data!;
      update();
      changeState(ProfileViewState.none);
    } catch (e) {
      changeState(ProfileViewState.error);
    }
  }


}
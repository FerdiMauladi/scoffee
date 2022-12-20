
import 'dart:io';

import 'package:flutter/material.dart' hide BottomAppBar;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/data/model/user_model.dart';
import 'package:scoffee/screen/bottomappbar/bottomappbar.dart';

enum ProfileViewState {
  none,
  loading,
  loadingStatus,
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
  final bornController = TextEditingController();
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
    var id = await storageSecure.read(key: "id");
    int ids = int.parse(id!);
    try {
      var data = await repository.getDataUser(ids);
      userModel = data!;
      nameController.text = userModel.name ?? '';
      emailController.text = userModel.email ?? '';
      descriptionController.text = userModel.userDetail?.description ?? '';
      bornController.text = userModel.userDetail?.born ?? '';
      lastEducationController.text = userModel.userDetail?.academic ?? '';
      workController.text = userModel.userDetail?.work ?? '';
      update();
      changeState(ProfileViewState.none);
    } catch (e) {
      changeState(ProfileViewState.error);
    }
  }

  Future updateUser() async {
    changeState(ProfileViewState.loadingStatus);
    try {
      await repository
          .postProfile(
        name: nameController.text,
        email: emailController.text,
        description: descriptionController.text,
        born: bornController.text,
        academic: lastEducationController.text,
        work: workController.text,
        image: pathFoto,
      )
          .then(
            (_) {
              changeState(ProfileViewState.none);
          Get.showSnackbar(
            const GetSnackBar(
              message: 'User berhasil di update',
              isDismissible: true,
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ),
          );
          Get.off(() => const BottomAppBar());
        },
      );
    } catch (e) {
      changeState(ProfileViewState.loading);
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Ada kesalahan saat ingin update user',
          isDismissible: true,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  
}
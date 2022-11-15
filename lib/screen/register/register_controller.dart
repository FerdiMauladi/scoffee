
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoffee/base/base_controller.dart';

class RegisterController extends BaseController {
  bool isErrorPasswordRegister = false;
  bool isErrorConfirmRegister = false;
  bool isObscurePasswordRegister = true;
  bool isObscureConfirmPasswordRegister = true;
  bool isLoading = false;

  final formKeyRegister = GlobalKey<FormState>();

  final namaRegisterController = TextEditingController();
  final emailRegisterController = TextEditingController();
  final passwordRegisterController = TextEditingController();
  final confirmPasswordRegisterController = TextEditingController();

  @override
  void dispose() {
    namaRegisterController.dispose();
    emailRegisterController.dispose();
    passwordRegisterController.dispose();
    confirmPasswordRegisterController.dispose();
    super.dispose();
  }

  Future doRegister(
      {required String name,
        required String email,
        required String password}) async {
    try {
      await repository.register(name: name, email: email, password: password).then((_) => Get.showSnackbar(
            const GetSnackBar(
              message: 'Pendaftaran berhasil, silahkan login',
              isDismissible: true,
              duration: Duration(seconds: 3),
              backgroundColor: Colors.green,
            ),
          )).then((_) => Get.back());
    } catch (e) {
      // if (e.toString().contains('Username tidak ditemukan')) {
      //   Get.showSnackbar(
      //     const GetSnackBar(
      //       message: 'Username tidak ditemukan, harap daftar terlebih dahulu',
      //       isDismissible: true,
      //       duration: Duration(seconds: 3),
      //       backgroundColor: Colors.red,
      //     ),
      //   );
      // } else {
      return e;
      // }
    }
  }
}

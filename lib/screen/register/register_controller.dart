import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/screen/login/login_screen.dart';

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
      var response = await repository.register(
          name: name, email: email, password: password);
      if (response.statusCode == 201) {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Pendaftaran berhasil, silahkan login',
            isDismissible: true,
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
          ),
        );
        Get.offAll(() => const LoginScreen());
      }
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

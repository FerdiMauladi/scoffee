import 'package:flutter/material.dart' hide BottomAppBar;
import 'package:get/get.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/screen/bottomappbar/bottomappbar.dart';

class LoginController extends BaseController {
  bool isError = false;
  bool isErrorEmailLogin = false;
  bool isErrorPasswordLogin = false;
  bool isObscurePasswordLogin = true;
  bool isRemember = false;

  final formKey = GlobalKey<FormState>();
  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
    super.dispose();
  }

  Future doLogin({required String email, required String password}) async {
    try {
      await repository
          .login(email: email, password: password)
          .then((data) {
          storage.saveToken(data.data?.token ?? '-');
          storage.saveId(data.data?.user?.id.toString() ?? '-');
            return data;
      })
          .then(
            (_) => Get.showSnackbar(
              const GetSnackBar(
                message: 'Login berhasil',
                isDismissible: true,
                duration: Duration(seconds: 3),
                backgroundColor: Colors.green,
              ),
            ),
          )
          .then((_) => Get.offAll(() => const BottomAppBar()));
    } catch (e) {
      if (e.toString().contains('Username tidak ditemukan')) {
        Get.showSnackbar(
          const GetSnackBar(
            icon: Icon(
              Icons.error,
              color: Colors.white,
            ),
            message: 'Username tidak ditemukan, harap daftar terlebih dahulu',
            isDismissible: true,
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        return e;
      }
    }
  }
}

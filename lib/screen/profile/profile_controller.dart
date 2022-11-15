import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/screen/login/login_screen.dart';

class ProfileController extends BaseController {
  final storageSecure = const FlutterSecureStorage();

  Future logout() async {
    final String? token = await storageSecure.read(key: 'token');
    try {
      await repository
          .logout(token!)
          .then((_) => storage.deleteToken())
          .then((_) => Get.offAll(() => const LoginScreen()));
    } catch (e) {
      print(e);
      return;
    }
  }
}

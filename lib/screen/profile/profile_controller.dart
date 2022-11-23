import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/data/model/user_model.dart';
import 'package:scoffee/screen/login/login_screen.dart';

enum ProfileViewState {
  none,
  loading,
  error,
}


class ProfileController extends BaseController {
  final storageSecure = const FlutterSecureStorage();
  UserModel userModel = UserModel();
  ProfileViewState _state = ProfileViewState.none;
  ProfileViewState get state => _state;


  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  changeState(ProfileViewState s) {
    _state = s;
    update();
  }

  Future getUser() async {
    changeState(ProfileViewState.loading);
    try {
      var data = await repository.getDataUser();
      print(data!);
      userModel = data;
      update();
      changeState(ProfileViewState.none);
    } catch (e) {
      print(e);
      changeState(ProfileViewState.error);
    }
  }

  Future logout() async {
    final String? token = await storageSecure.read(key: 'token');
    try {
      await repository
          .logout(token!)
          .then((_) => storage.deleteToken())
          .then((_) => Get.offAll(() => const LoginScreen()));
    } catch (e) {
      print(e);
      changeState(ProfileViewState.error);
    }
  }
}

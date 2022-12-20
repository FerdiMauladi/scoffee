import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/data/model/user_model.dart';
import 'package:scoffee/screen/login/login_screen.dart';

import '../../../data/model/forum_model.dart';

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

  final PagingController<int, Data?> pagingController =
  PagingController(firstPageKey: 1);


  @override
  void onInit() {
    getUser();
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.onInit();
  }

  changeState(ProfileViewState s) {
    _state = s;
    update();
  }

  Future getUser() async {
    changeState(ProfileViewState.loading);
    var id = await storageSecure.read(key: "id");
    int ids = int.parse(id!);
    try {
      var data = await repository.getDataUser(ids);
      userModel = data!;
      update();
      changeState(ProfileViewState.none);
    } catch (e) {
      changeState(ProfileViewState.error);
    }
  }

  Future<void> fetchPage(int pageKey) async {
      try {
        final newItems = await repository.getDataUserForum(pageKey);
        final isLastPage = newItems!.nextPageUrl == null;
        if (isLastPage) {
          pagingController.appendLastPage(newItems.data!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems.data!, nextPageKey);
        }
      } catch (e) {
        pagingController.error = e;
      }

  }

  Future<void> postLike(int idForum) async {
    try {
      await repository
          .postLike(idForum)
          .then((value) => pagingController.refresh());
    } catch (e) {
      changeState(ProfileViewState.error);
    }
  }

  Future<void> postDelete(int idForum) async {
    try {
      await repository
          .postDelete(idForum)
          .then((value) {
        pagingController.refresh();
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Postingan berhasil di delete',
            isDismissible: true,
            duration: Duration(seconds: 2),
            backgroundColor: Colors.green,
          ),
        );
      });
    } catch (e) {
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
      changeState(ProfileViewState.error);
    }
  }
}

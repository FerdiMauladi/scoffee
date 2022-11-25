import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/data/model/user_model.dart';

import '../../../data/model/coffee_model.dart';

enum CoffeeViewState {
  none,
  loading,
  error,
}

class CoffeeController extends BaseController {
  UserModel userModel = UserModel();
  CoffeeViewState _state = CoffeeViewState.none;
  CoffeeViewState get state => _state;


  final searchController = TextEditingController();


  final PagingController<int, Data?> pagingController =
  PagingController(firstPageKey: 1);

  changeState(CoffeeViewState s) {
    _state = s;
    update();
  }

  @override
  void onInit() {
    getUser();
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.onInit();
  }

  Future getUser() async {
    changeState(CoffeeViewState.loading);
    try {
      var data = await repository.getDataUser();
      userModel = data!;
      update();
      changeState(CoffeeViewState.none);
    } catch (e) {
      changeState(CoffeeViewState.error);
    }
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final newItems = await repository.getDataCoffee(pageKey);
      final isLastPage = newItems!.nextPageUrl == null;
      if (isLastPage) {
        pagingController.appendLastPage(newItems.data!);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems.data!, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}

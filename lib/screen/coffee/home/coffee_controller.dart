import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/base/base_controller.dart';

import '../../../data/model/coffee_model.dart';

class CoffeeController extends BaseController {
  // List<DummyHomeModel> _listDataDummy = <DummyHomeModel>[];
  //
  // List<DummyHomeModel> get listDataDummy => _listDataDummy;
  // List<List<DummyHomeModel>> _listAllDataDummy = [];
  //
  // List<List<DummyHomeModel>> get listAllDataDummy => _listAllDataDummy;
  //
  // int currentPage = 0;
  // List<List<DummyHomeModel>> listAllDummy = [];
  // bool isLoading = true;
  // bool isSearching = false;
  //
  // final pageController = PageController();
  final searchController = TextEditingController();


  final PagingController<int, Data?> pagingController =
  PagingController(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.onInit();
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

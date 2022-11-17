import 'package:flutter/material.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/const/app_const.dart';
import 'package:scoffee/data/model/dummy_home_model.dart';

class CoffeeController extends BaseController {
  List<DummyHomeModel> _listDataDummy = <DummyHomeModel>[];

  List<DummyHomeModel> get listDataDummy => List.unmodifiable(_listDataDummy);
  List<List<DummyHomeModel>> _listAllDataDummy = [];

  List<List<DummyHomeModel>> get listAllDataDummy =>
      List.unmodifiable(_listAllDataDummy);

  int currentPage = 0;
  List<List<DummyHomeModel>> listAllDummy = [];
  bool isLoading = true;
  bool isSearching = false;

  final pageController = PageController();
  final searchController = TextEditingController();

  @override
  void onInit() {
    getData();
    listAllDummy = listAllDataDummy;
    super.onInit();
  }

  void getData() {
    _listDataDummy = AppConst.dataList;
    _listAllDataDummy = [
      _listDataDummy.where((element) => element.kategori == 'Sejarah').toList(),
      _listDataDummy
          .where((element) => element.kategori == 'Education')
          .toList(),
      _listDataDummy.where((element) => element.kategori == 'Barista').toList(),
      _listDataDummy.where((element) => element.kategori == 'Kopi').toList(),
      _listDataDummy.where((element) => element.kategori == 'Latihan').toList(),
    ];
  }
}

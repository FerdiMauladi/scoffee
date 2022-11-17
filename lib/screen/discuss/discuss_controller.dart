
import 'package:flutter/material.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/const/app_const.dart';
import 'package:scoffee/data/model/dummy_home_model.dart';

class DiscussController extends BaseController {
  int currentPage = 0;
  List<DummyHomeModel> _listDataDummy = <DummyHomeModel>[];

  List<DummyHomeModel> get listDataDummy => _listDataDummy;
  List<List<DummyHomeModel>> _listAllDataDummy = [];

  List<List<DummyHomeModel>> get listAllDataDummy => _listAllDataDummy;

  final pageController = PageController();

  @override
  void onInit() {
    getData();
    super.onInit();
  }


  void getData() {
    _listDataDummy = AppConst.dataListDiscuss;
    _listAllDataDummy = [
      _listDataDummy.where((element) => element.kategori == 'Kopi Java Sumedang').toList(),
      _listDataDummy
          .where((element) => element.kategori == 'Kopi Tanjoeng')
          .toList(),
      _listDataDummy.where((element) => element.kategori == 'Kopi Karuhun').toList(),
      _listDataDummy.where((element) => element.kategori == 'Kopi Matim').toList(),
      _listDataDummy.where((element) => element.kategori == 'Kopi Boehoen').toList(),
      _listDataDummy.where((element) => element.kategori == 'Kopi Lingga Sari').toList(),
      _listDataDummy.where((element) => element.kategori == 'Kopi Gunung Susuru').toList(),
    ];
  }
}
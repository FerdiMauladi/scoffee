
import 'package:get/get.dart';
import 'package:scoffee/data/network_core.dart';
import 'package:scoffee/data/repository/repository.dart';
import 'package:scoffee/data/repository/repository_impl.dart';
import 'package:scoffee/data/storage_core.dart';


class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<NetworkCore>(NetworkCore(), permanent: true);
    Get.put<StorageCore>(StorageCore(), permanent: true);
    Get.put<Repository>(RepositoryImpl(), permanent: true);
  }
}
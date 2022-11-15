
import 'package:get/get.dart';
import 'package:scoffee/data/repository/repository.dart';
import 'package:scoffee/data/storage_core.dart';

abstract class BaseController extends GetxController {
  final repository = Get.find<Repository>();
  final storage = Get.find<StorageCore>();
}
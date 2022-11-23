
import 'package:get/get.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/data/model/detail_coffee_model.dart';

enum DetailCoffeeViewState {
  none,
  loading,
  error,
}

class DetailCoffeeController extends BaseController {
  DetailCoffeeViewState _state = DetailCoffeeViewState.none;
  DetailCoffeeViewState get state => _state;
  DetailCoffeeModel detailCoffee = DetailCoffeeModel();
  var id = Get.arguments;

  changeState(DetailCoffeeViewState s) {
    _state = s;
    update();
  }

  @override
  void onInit() {
    getDetailCoffee();
    super.onInit();
  }

  Future getDetailCoffee() async {
    changeState(DetailCoffeeViewState.loading);
    try {
      var data = await repository.getDetailCoffee(id['id']);
      detailCoffee = data!;
      update();
      changeState(DetailCoffeeViewState.none);
    } catch (e) {
      print(e);
      changeState(DetailCoffeeViewState.error);
    }
  }

}
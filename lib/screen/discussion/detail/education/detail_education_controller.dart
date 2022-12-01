
import 'package:get/get.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/data/model/detail_education_model.dart';

enum DetailEducationState {
  none,
  loading,
  error,
}

class DetailEducationController extends BaseController {
  DetailEducationState _state = DetailEducationState.none;
  DetailEducationState get state => _state;
  var id = Get.arguments;
  DetailEducationModel detailEducation = DetailEducationModel();

  changeState(DetailEducationState s) {
    _state = s;
    update();
  }

  @override
  void onInit() {
    getDetailEducation();
    super.onInit();
  }

  Future getDetailEducation() async {
    changeState(DetailEducationState.loading);
    try {
      var data = await repository.getDetailEducation(id['id']);
      detailEducation = data!;
      update();
      changeState(DetailEducationState.none);
    } catch (e) {
      print(e);
      changeState(DetailEducationState.error);
    }
  }

}
import 'package:get/get.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/data/model/detail_event_model.dart';

enum DetailEventState {
  none,
  loading,
  error,
}

class DetailEventController extends BaseController {
  DetailEventState _state = DetailEventState.none;
  DetailEventState get state => _state;
  var id = Get.arguments;
  DetailEventModel detailEvent = DetailEventModel();

  changeState(DetailEventState s) {
    _state = s;
    update();
  }

  @override
  void onInit() {
    getDetailEvent();
    super.onInit();
  }

  Future getDetailEvent() async {
    changeState(DetailEventState.loading);
    try {
      var data = await repository.getDetailEvent(id['id']);
      detailEvent = data!;
      update();
      changeState(DetailEventState.none);
    } catch (e) {
      changeState(DetailEventState.error);
    }
  }
}

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/const/app_const.dart';
import 'package:scoffee/data/model/category_model.dart';

import '../../../data/model/forum_model.dart';

enum DiscussViewState {
  none,
  loading,
  error,
}

class DiscussController extends BaseController {

  List<CategoryModel?> listCategory = [];
  DiscussViewState _state = DiscussViewState.none;
  DiscussViewState get state => _state;

  final PagingController<int, Data?> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    fetchCategory();
    super.onInit();
  }

  changeState(DiscussViewState s) {
    _state = s;
    update();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final newItems = await repository.getDataForum(pageKey);
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

  Future<void> fetchCategory() async {
    changeState(DiscussViewState.loading);
    try {
      final data = await repository.getDataCategory();
      listCategory = data;
      changeState(DiscussViewState.none);
    } catch (e) {
      changeState(DiscussViewState.error);
    }
  }
}

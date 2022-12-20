import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/data/model/category_model.dart';
import 'package:scoffee/data/model/education_model.dart';
import 'package:scoffee/data/model/user_model.dart';

import '../../../data/model/forum_model.dart';

enum DiscussViewState {
  none,
  loading,
  error,
}

class DiscussController extends BaseController {
  List<CategoryModel?> listCategory = [];
  String categoryTerm = '';
  bool isDiscuss = true;
  int indexCategory = 1;
  UserModel? userModel = UserModel();
  int? userId;
  DiscussViewState _state = DiscussViewState.none;

  DiscussViewState get state => _state;

  final PagingController<int, Data?> pagingController =
      PagingController(firstPageKey: 1);

  final PagingController<int, DataEdu?> pagingControllerEdu =
      PagingController(firstPageKey: 1);

  @override
  void onInit() {
    fetchCategory();
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    pagingController.refresh();
    pagingControllerEdu.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    pagingControllerEdu.refresh();
    super.onInit();
  }

  changeState(DiscussViewState s) {
    _state = s;
    update();
  }

  Future<void> fetchPage(int pageKey) async {
    if (isDiscuss == true) {
      try {
        final newItems = await repository.getDataForum(pageKey, categoryTerm);
        final isLastPage = newItems!.nextPageUrl == null;
        if (isLastPage) {
          pagingController.appendLastPage(newItems.data!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems.data!, nextPageKey);
        }
      } catch (e) {
        pagingController.error = e;
      }
    }

    if (isDiscuss == false) {
      try {
        final newItems =
            await repository.getDataEducation(pageKey, categoryTerm);
        final isLastPage = newItems!.nextPageUrl == null;
        if (isLastPage) {
          pagingControllerEdu.appendLastPage(newItems.data!);
        } else {
          final nextPageKey = pageKey + 1;
          pagingControllerEdu.appendPage(newItems.data!, nextPageKey);
        }
      } catch (e) {
        pagingControllerEdu.error = e;
      }
    }
  }

  Future<void> postLike(int idForum) async {
    try {
      await repository
          .postLike(idForum)
          .then((value) => pagingController.refresh());
    } catch (e) {
      changeState(DiscussViewState.error);
    }
  }

  Future<void> fetchCategory() async {
    changeState(DiscussViewState.loading);
    try {
      final data = await repository.getDataCategory();
      listCategory = data;
      categoryTerm = listCategory[0]!.name!;
      changeState(DiscussViewState.none);
    } catch (e) {
      changeState(DiscussViewState.error);
    }
  }
}

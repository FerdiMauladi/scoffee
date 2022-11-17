
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/data/model/event_model.dart';

class EventController extends BaseController {

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
      final newItems = await repository.getDataEvent(pageKey);
      final isLastPage = newItems!.data!.length < newItems.to!;
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

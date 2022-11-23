import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/data/model/detail_discuss_model.dart';

enum DetailDiscussViewState {
  none,
  loading,
  error,
}

class DetailDiscussController extends BaseController {
  DetailDiscussViewState _state = DetailDiscussViewState.none;

  DetailDiscussViewState get state => _state;
  var id = Get.arguments;
  DetailDiscussModel detailDiscuss = DetailDiscussModel();
  DetailDiscussModel detailForums = DetailDiscussModel();

  final PagingController<int, Data?> pagingController =
      PagingController(firstPageKey: 1);
  final commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    fetchData();
    super.onInit();
  }

  changeState(DetailDiscussViewState s) {
    _state = s;
    update();
  }

  Future fetchData() async {
    changeState(DetailDiscussViewState.loading);
    try {
      final detailComment = await repository.getForum(id: id['id']);
      detailForums = detailComment!;
      changeState(DetailDiscussViewState.none);
    } catch (e) {
      changeState(DetailDiscussViewState.error);
    }
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final newItems = await repository.getDetailForum(
        id: id['id'],
        pageKey: pageKey,
      );
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

  Future postComment(String forumId) async {
    try {
      var response = await repository.postComment(
        idForum: forumId,
        comment: commentController.text,
      );
    } catch (e) {
      print(e);
      return;
    }
  }
}

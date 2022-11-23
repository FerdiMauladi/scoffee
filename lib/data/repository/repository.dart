import 'package:dio/dio.dart';
import 'package:scoffee/data/model/category_model.dart';
import 'package:scoffee/data/model/coffee_model.dart';
import 'package:scoffee/data/model/detail_coffee_model.dart';
import 'package:scoffee/data/model/detail_discuss_model.dart';
import 'package:scoffee/data/model/detail_event_model.dart';
import 'package:scoffee/data/model/event_model.dart';
import 'package:scoffee/data/model/forum_model.dart';
import 'package:scoffee/data/model/login_model.dart';
import 'package:scoffee/data/model/user_model.dart';

abstract class Repository {
  Future<LoginModel> login({
    required String email,
    required String password,
  });

  Future register({
    required String email,
    required String password,
    required String name,
  });

  Future logout(String token);
  Future<EventModel?> getDataEvent(int pageKey);
  Future<DetailEventModel?> getDetailEvent(String id);
  Future<UserModel?> getDataUser();
  Future<CoffeeModel?> getDataCoffee(int pageKey);
  Future<DetailCoffeeModel?> getDetailCoffee(String id);
  Future<ForumModel?> getDataForum(int pageKey);
  Future<Comments?> getDetailForum({ required String id, required int pageKey});
  Future<Response> postComment({ required String idForum, required String comment});
  Future<DetailDiscussModel?> getForum({ required String id});
  Future<List<CategoryModel?>> getDataCategory();
}

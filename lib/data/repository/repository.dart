import 'dart:io';

import 'package:dio/dio.dart';
import 'package:scoffee/data/model/category_model.dart';
import 'package:scoffee/data/model/coffee_model.dart';
import 'package:scoffee/data/model/detail_coffee_model.dart';
import 'package:scoffee/data/model/detail_discuss_model.dart';
import 'package:scoffee/data/model/detail_education_model.dart';
import 'package:scoffee/data/model/detail_event_model.dart';
import 'package:scoffee/data/model/education_model.dart';
import 'package:scoffee/data/model/event_model.dart';
import 'package:scoffee/data/model/forum_model.dart';
import 'package:scoffee/data/model/login_model.dart';
import 'package:scoffee/data/model/user_model.dart';

abstract class Repository {
  Future<LoginModel> login({
    required String email,
    required String password,
  });

  Future<Response> register({
    required String email,
    required String password,
    required String name,
  });

  Future logout(String token);

  Future<EventModel?> getDataEvent(int pageKey);

  Future<DetailEventModel?> getDetailEvent(int id);

  Future<UserModel?> getDataUser();

  Future<CoffeeModel?> getDataCoffee(int pageKey);

  Future<DetailCoffeeModel?> getDetailCoffee(int id);

  Future<ForumModel?> getDataForum(int pageKey, String category);

  Future<EducationModel?> getDataEducation(int pageKey, String category);
  Future<DetailEducationModel?> getDetailEducation(int id);

  Future<Comments?> getDetailForum({required int id, required int pageKey});

  Future<DetailDiscussModel?> getForum({required int id});

  Future<List<CategoryModel?>> getDataCategory();

  Future<Response> postComment(
      {required int idForum, required String comment});

  Future<Response> postForum({
    required int categoryId,
    required String title,
    required String description,
    File? image,
  });

  Future<Response> postProfile();
}

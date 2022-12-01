import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
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
import 'package:scoffee/data/network_core.dart';
import 'package:scoffee/data/repository/repository.dart';

class RepositoryImpl implements Repository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<LoginModel> login(
      {required String email, required String password}) async {
    try {
      Response response = await network.dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return LoginModel.fromJson(response.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('Username tidak ditemukan');
      }
      throw Exception(e.message);
    }
  }

  @override
  Future<Response> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      Response response = await network.dio.post('/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future logout(String token) async {
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await network.dio.post('/logout');
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<EventModel?> getDataEvent(int pageKey) async {
    // network.dio.options.headers['Authorization'] = 'Bearer $token';
    var token = await storageSecure.read(key: "token");
    try {
      final response = await network.dio.get('/events',
          queryParameters: {"page": pageKey},
          options: Options(headers: {"Authorization": "Bearer $token"}));
      return EventModel.fromJson(response.data["data"]);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<UserModel?> getDataUser() async {
    var token = await storageSecure.read(key: "token");
    var id = await storageSecure.read(key: "id");
    int ids = int.parse(id!);
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await network.dio.get('/user/$ids');
      return UserModel.fromJson(response.data['data']['user']);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<CoffeeModel?> getDataCoffee(int pageKey) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await network.dio.get(
        '/coffee',
        queryParameters: {
          "page": pageKey,
        },
      );
      return CoffeeModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<ForumModel?> getDataForum(int pageKey, String category) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await network.dio.get(
        '/category/$category/relationships/posting',
        queryParameters: {
          "page": pageKey,
        },
      );
      return ForumModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<List<CategoryModel?>> getDataCategory() async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await network.dio.get(
        '/category',
      );
      List<dynamic> listData = response.data['data'];
      List<CategoryModel> listCategory =
          listData.map((e) => CategoryModel.fromJson(e)).toList();
      return listCategory;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<DetailCoffeeModel?> getDetailCoffee(int id) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await network.dio.get('/coffee/$id');
      return DetailCoffeeModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<Comments?> getDetailForum(
      {required int id, required int pageKey}) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await network.dio.get(
        '/posting/$id/comment',
        queryParameters: {
          "page": pageKey,
        },
      );
      return Comments.fromJson(response.data['data']['comments']);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<DetailDiscussModel?> getForum({required int id}) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await network.dio.get(
        '/posting/$id/comment',
      );
      return DetailDiscussModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<DetailEventModel?> getDetailEvent(int id) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await network.dio.get('/events/$id');
      return DetailEventModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<Response> postComment(
      {required int idForum, required String comment}) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      var formData = FormData.fromMap({
        "forum_id": idForum,
        "comment": comment,
      });
      final response = await network.dio.post(
        '/comment',
        data: formData,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
        }),
      );
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<EducationModel?> getDataEducation(int pageKey, String category) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await network.dio.get(
        '/education',
        queryParameters: {
          "page": pageKey,
          "category" : category,
        },
      );
      return EducationModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<Response> postForum({required int categoryId, required String title, required String description, File? image}) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      var formData = FormData.fromMap({
        "category_id": categoryId,
        "context_id": 1,
        "title" : title,
        "description" : description,
      });

      if (image != null) {
        formData.files.addAll(
            [MapEntry("image", await MultipartFile.fromFile(image.path))]);
      }

      var response = await network.dio.post("/posting",
          data: formData,
          options: Options(headers: {
            "Content-Type": "multipart/form-data"
          }));
      return response;
    } on DioError catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<DetailEducationModel?> getDetailEducation(int id) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await network.dio.get('/education/$id');
      return DetailEducationModel.fromJson(response.data['data']);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Future<Response> postProfile() {
    // TODO: implement postProfile
    throw UnimplementedError();
  }
}

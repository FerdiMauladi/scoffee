import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:scoffee/data/model/category_model.dart';
import 'package:scoffee/data/model/coffee_model.dart';
import 'package:scoffee/data/model/detail_coffee_model.dart';
import 'package:scoffee/data/model/detail_discuss_model.dart';
import 'package:scoffee/data/model/detail_event_model.dart';
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
  Future register(
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
  Future<ForumModel?> getDataForum(int pageKey) async {
    var token = await storageSecure.read(key: "token");
    network.dio.options.headers['Authorization'] = 'Bearer $token';
    try {
      final response = await network.dio.get(
        '/posting',
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
  Future<DetailCoffeeModel?> getDetailCoffee(String id) async {
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
      {required String id, required int pageKey}) async {
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
  Future<DetailDiscussModel?> getForum({required String id}) async {
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
  Future<DetailEventModel?> getDetailEvent(String id) async {
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
  Future<Response> postComment({required String idForum, required String comment}) async {
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
        options: Options(
          headers: {
            "Content-Type" : "multipart/form-data",
          }
        ),
      );
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}

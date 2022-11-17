import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;
import 'package:scoffee/data/model/event_model.dart';
import 'package:scoffee/data/model/login_model.dart';
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
      final response = await network.dio.get(
        '/events',
        queryParameters: {
          "page": pageKey
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token"
          }
        )
      );
      return EventModel.fromJson(response.data["data"]);
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}

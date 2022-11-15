

import 'package:scoffee/data/model/login_model.dart';
import 'package:scoffee/data/model/toko_model.dart';

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
}

import 'package:scoffee/data/model/event_model.dart';
import 'package:scoffee/data/model/login_model.dart';

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
}

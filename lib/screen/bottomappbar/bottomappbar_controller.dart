import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/screen/coffee/coffee_screen.dart';
import 'package:scoffee/screen/discuss/discuss_screen.dart';
import 'package:scoffee/screen/event/event_screen.dart';
import 'package:scoffee/screen/profile/profile_screen.dart';

class BottomAppBarController extends BaseController {
  int indexHalaman = 0;

  List screen = [
    const CoffeeScreen(),
    const DiscussScreen(),
    const EventScreen(),
    const ProfileScreen(),
  ];

  // @override
  // void onInit() {
  //   storage.deleteToken();
  //   super.onInit();
  // }

}

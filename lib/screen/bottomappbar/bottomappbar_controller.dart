import 'package:scoffee/base/base_controller.dart';
import 'package:scoffee/screen/coffee/home/coffee_screen.dart';
import 'package:scoffee/screen/discussion/discuss/discuss_screen.dart';
import 'package:scoffee/screen/event/home/event_screen.dart';
import 'package:scoffee/screen/profile/home/profile_home_screen.dart';


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

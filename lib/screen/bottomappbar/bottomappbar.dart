import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoffee/screen/bottomappbar/bottomappbar_controller.dart';

class BottomAppBar extends StatelessWidget {
  const BottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomAppBarController>(
      init: BottomAppBarController(),
      builder: (controller) {
        return Scaffold(
          body: controller.screen.elementAt(controller.indexHalaman),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF362204),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 16,
                ),
              ],
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 16,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: const Color(0xFFBF8E2C),
              unselectedItemColor: Colors.white,
              iconSize: 30,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              backgroundColor: const Color(0xFF362204),
              currentIndex: controller.indexHalaman,
              onTap: (value) {
                controller.indexHalaman = value;
                controller.update();
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.coffee),
                  label: "Coffee",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble),
                  label: "Discuss",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.event),
                  label: "Event",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Profile",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

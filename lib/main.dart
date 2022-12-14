import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scoffee/binding/global_binding.dart';
import 'package:scoffee/screen/splash/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.black,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  GlobalBinding().dependencies();
  runApp(const Scoffee());
}

class Scoffee extends StatelessWidget {
  const Scoffee({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scoffee',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

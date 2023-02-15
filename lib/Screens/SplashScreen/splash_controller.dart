import 'dart:async';
import 'package:flutter_practicle/Screens/DashBoard/dashboard_screen.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    getRoutes();
    super.onInit();
  }

  void getRoutes() {
    Future.delayed(const Duration(seconds: 3),
        () => Get.offAndToNamed(DashBoardScreen.routeName));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_practicle/Screens/SplashScreen/splash_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/SplashScreen';

  SplashScreen({Key? key}) : super(key: key);
  final SplashController _splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: const [
            Expanded(
              child: Center(
                child: Text(
                  'Splash Screen',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practicle/Helper/LocalStorage/shared_preferences.dart';
import 'package:flutter_practicle/Screens/DashBoard/dashboard_screen.dart';
import 'package:flutter_practicle/Screens/SplashScreen/splash_screen.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.initMySharedPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        initialBinding: AppBinding(),
        getPages: [
          GetPage(
              name: SplashScreen.routeName,
              page: () => SplashScreen(),
              transition: Transition.fadeIn),
          GetPage(
              name: DashBoardScreen.routeName,
              page: () => DashBoardScreen(),
              transition: Transition.fadeIn),
        ],
      );
    });
  }
}

class AppBinding extends Bindings {
  @override
  void dependencies() {}
}

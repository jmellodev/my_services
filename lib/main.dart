import 'package:flutter/material.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:my_services/constants/app_themes.dart';
import 'package:my_services/constants/firebase_constants.dart';
import 'package:my_services/controllers/auth_controller.dart';
import 'package:my_services/controllers/theme_controller.dart';
import 'package:my_services/routes/app_routes.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  firebaseInitialization.then((value) {
    // we are going to inject the auth controller over here!
    Get.put(AuthController());
  });
  Get.put<ThemeController>(ThemeController());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Services',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: "/",
      getPages: AppRoutes.routes,
      // home: Scaffold(
      //   body: Center(
      //     child: CircularProgressIndicator(),
      //   ),
      // ),
    );
  }
}

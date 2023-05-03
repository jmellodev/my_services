import 'package:get/get.dart';

import 'package:my_services/screens/auth/login.dart';
import 'package:my_services/screens/auth/register_view.dart';
import 'package:my_services/screens/home.dart';
import 'package:my_services/ui/settings_ui.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => HomeView()),
    GetPage(name: '/login', page: () => const LoginPage()),
    GetPage(name: '/register', page: () => const RegisterView()),
    GetPage(name: '/settings', page: () => const SettingsUI()),
    // GetPage(name: '/reset-password', page: () => ResetPasswordUI()),
    // GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
  ];
}

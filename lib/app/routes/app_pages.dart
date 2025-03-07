import 'package:flutter_application_1/app/modules/home/views/HomePage.dart';
import 'package:flutter_application_1/app/modules/home/views/intro_page.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => IntroPage(),
      binding: HomeBinding(),
    ),
  ];
}

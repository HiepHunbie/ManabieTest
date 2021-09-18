import 'package:demo/view/home/home_view.dart';
import 'package:get/get.dart';

class Routers {
  static final route = [
    GetPage(
      name: '/homeView',
      page: () => HomeView(),
    ),
  ];
}

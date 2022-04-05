import 'package:get/get.dart';
import 'package:memo_sqflite/controllers/app_controller.dart';
import 'package:memo_sqflite/controllers/home_controller.dart';
import 'package:memo_sqflite/controllers/search_controller.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.put(HomeController());
    Get.put(SearchController());
  }
}

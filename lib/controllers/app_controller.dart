import 'package:get/get.dart';

class AppController extends GetxService {
  static AppController get to => Get.find();

  Rx<int> currentIndex = 0.obs;

  changeIndex(int index) {
    currentIndex(index);
  }
}

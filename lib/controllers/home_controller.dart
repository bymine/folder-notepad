import 'package:get/get.dart';
import 'package:memo_sqflite/db_helper.dart';
import 'package:memo_sqflite/models/folder.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxList<Folder> folders = RxList([]);

  @override
  void onInit() {
    getAllFolders();
    super.onInit();
  }

  int get totalMemo {
    int memoSize = 0;
    for (var element in folders) {
      memoSize += element.folderSize;
    }
    return memoSize;
  }

  int get totalFolder => folders.length;

  getAllFolders() async {
    List<Map<String, dynamic>> loadFolders = await DBHelper().getAllFolders();
    folders(loadFolders.map((data) => Folder.fromJson(data)).toList());
  }

  clearAll() async {
    await DBHelper().resetAll();
    getAllFolders();
  }
}

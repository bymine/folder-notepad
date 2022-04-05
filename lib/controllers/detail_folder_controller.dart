import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:memo_sqflite/controllers/home_controller.dart';
import 'package:memo_sqflite/controllers/search_controller.dart';
import 'package:memo_sqflite/db_helper.dart';
import 'package:memo_sqflite/models/folder.dart';
import 'package:memo_sqflite/models/memo.dart';

class DetailFolderController extends GetxController {
  static DetailFolderController get to => Get.find();
  Rx<Folder> currentFolder =
      Rx<Folder>(Get.arguments[int.parse(Get.parameters['current']!)]);
  List<Folder> allFolder = Get.arguments;
  TextEditingController nameController = TextEditingController();

  RxList<Memo> memos = RxList([]);
  late RxInt selectColor;
  @override
  void onInit() {
    getFolderMemos();
    super.onInit();
    selectColor = currentFolder.value.folderColor.obs;
    nameController.text = currentFolder.value.folderName;
  }

  @override
  void onClose() {
    HomeController.to.getAllFolders();
    SearchController.to.loadAllFolder();
    SearchController.to.loadAllMemos();
    super.onClose();
  }

  getFolderInfo() async {
    List<Map<String, dynamic>> memoInfo =
        await DBHelper().getFolder(currentFolder.value);

    currentFolder(Folder.fromJson(memoInfo.first));
    currentFolder.refresh();
  }

  getFolderMemos() async {
    List<Map<String, dynamic>> loadMemos =
        await DBHelper().getFoldersMemo(currentFolder.value);

    memos(loadMemos.map((data) => Memo.fromJson(data)).toList());
  }

  void changeColor(int index) {
    selectColor(index);
  }

  updateFolder() async {
    var updateFolder = Folder(
        folderSize: currentFolder.value.folderSize,
        folderName: nameController.text,
        folderColor: selectColor.value,
        folderIdx: currentFolder.value.folderIdx);

    DBHelper().updateFolder(updateFolder);
    getFolderInfo();
  }

  deleteFolder() async {
    DBHelper().deleteFolder(currentFolder.value);
    Get.back();
  }

  bool checkDuplicationFolderName(String value) {
    allFolder.remove(currentFolder.value);
    return allFolder.any((element) => element.folderName == value);
  }
}

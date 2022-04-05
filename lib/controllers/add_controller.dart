import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_sqflite/controllers/home_controller.dart';
import 'package:memo_sqflite/controllers/search_controller.dart';
import 'package:memo_sqflite/db_helper.dart';
import 'package:memo_sqflite/models/folder.dart';
import 'package:memo_sqflite/models/memo.dart';

class AddController extends GetxController {
  static AddController get to => Get.find();

  RxList<Folder> folders = RxList([]);

  RxString selectedFolder = "".obs;
  RxBool isExistFolder = true.obs;
  RxInt selectColorIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getAllFolders();
  }

  @override
  void onClose() {
    HomeController.to.getAllFolders();
    SearchController.to.loadAllFolder();
    SearchController.to.loadAllMemos();
    super.onClose();
  }

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController bodyEditingController = TextEditingController();

  void getAllFolders() async {
    List<Map<String, dynamic>> loadFolders = await DBHelper().getAllFolders();
    folders
        .assignAll(loadFolders.map((data) => Folder.fromJson(data)).toList());
  }

  void insertMemo() async {
    var newMemo = Memo(
        folderIdx: 0,
        memoTitle: titleEditingController.text,
        memoBody: bodyEditingController.text,
        createdTime: DateTime.now().toIso8601String());

    if (isExistFolder.value) {
      var existFolder = folders
          .firstWhere((element) => element.folderName == selectedFolder.value);
      existFolder.folderSize++;
      newMemo.folderIdx = existFolder.folderIdx!;

      DBHelper().addMemo(newMemo, existFolder, isExistFolder.value);
    } else {
      var newFolder = Folder(
          folderSize: 1,
          folderName: selectedFolder.value,
          folderColor: selectColorIndex.value);
      DBHelper().addMemo(newMemo, newFolder, isExistFolder.value);
    }
    getAllFolders();
  }

  void selectFolder(Folder folder) {
    selectedFolder.value = folder.folderName;
    isExistFolder(
        folders.any((element) => element.folderName == selectedFolder.value));
  }

  void selectColor(int index) {
    selectColorIndex(index);
  }
}

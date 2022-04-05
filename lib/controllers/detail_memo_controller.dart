import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_sqflite/controllers/detail_folder_controller.dart';
import 'package:memo_sqflite/controllers/search_controller.dart';
import 'package:memo_sqflite/db_helper.dart';
import 'package:memo_sqflite/models/folder.dart';
import 'package:memo_sqflite/models/memo.dart';

class DetailMemoController extends GetxController {
  static DetailMemoController get to => Get.find();
  Rx<Memo> currentMemo = Rx<Memo>(Get.arguments[0]);
  Rx<Folder> currentFolder = Rx<Folder>(Get.arguments[1]);

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController bodyEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    titleEditingController.text = currentMemo.value.memoTitle;
    bodyEditingController.text = currentMemo.value.memoBody;
  }

  @override
  void onClose() {
    try {
      DetailFolderController.to.getFolderMemos();
      SearchController.to.loadAllMemos();
    } catch (e) {
      SearchController.to.loadAllMemos();
    }

    super.onClose();
  }

  bool isChanged() {
    if (currentMemo.value.memoTitle != titleEditingController.text ||
        currentMemo.value.memoBody != bodyEditingController.text) {
      return true;
    }
    return false;
  }

  updateMemo() async {
    currentMemo.value.updateTime = DateTime.now().toIso8601String();
    currentMemo.value.memoTitle = titleEditingController.text;
    currentMemo.value.memoBody = bodyEditingController.text;

    DBHelper().updateMemo(currentMemo.value);
  }

  deleteMemo() async {
    currentMemo.value.updateTime = DateTime.now().toIso8601String();
    currentMemo.value.memoTitle = titleEditingController.text;
    currentMemo.value.memoBody = bodyEditingController.text;

    currentFolder.value.folderSize--;
    update();
    DBHelper().deleteMemo(currentMemo.value);
    DBHelper().updateFolder(currentFolder.value);
  }
}

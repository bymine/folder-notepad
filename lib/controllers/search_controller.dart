import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_sqflite/db_helper.dart';
import 'package:memo_sqflite/models/folder.dart';
import 'package:memo_sqflite/models/memo.dart';

class SearchController extends GetxController {
  static SearchController get to => Get.find();
  Rx<String> searchKeyword = "".obs;
  TextEditingController textEditingController = TextEditingController();
  RxList<Memo> memos = RxList([]);

  RxList<Memo> containMemos = RxList([]);
  RxList<Folder> folders = RxList([]);

  @override
  void onInit() {
    loadAllMemos();
    loadAllFolder();
    super.onInit();
  }

  loadAllMemos() async {
    List<Map<String, dynamic>> loadMemos = await DBHelper().getAllMemos();
    memos(loadMemos.map((data) => Memo.fromJson(data)).toList());
  }

  loadAllFolder() async {
    List<Map<String, dynamic>> loadFolders = await DBHelper().getAllFolders();
    folders(loadFolders.map((data) => Folder.fromJson(data)).toList());
  }

  void clearSearchText() {
    searchKeyword("");
    textEditingController.clear();
  }

  inputSearchMemo(String value) {
    searchKeyword(value);
    containMemos.clear();
    for (var element in memos) {
      if (element.memoTitle.contains(value)) {
        containMemos.add(element);
      }
    }
  }

  Folder getFolderName(int folderIdx) {
    return folders.firstWhere(
      (element) => element.folderIdx == folderIdx,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:memo_sqflite/components/empty_folder_screen.dart';
import 'package:memo_sqflite/components/summary_panel.dart';
import 'package:memo_sqflite/controllers/search_controller.dart';
import 'package:memo_sqflite/models/memo.dart';
import 'package:memo_sqflite/views/detail_folder_page.dart';

class Search extends GetView<SearchController> {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller.textEditingController,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "메모 검색...",
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.blueGrey,
              ),
              hintStyle: Theme.of(context).textTheme.bodySmall,
              suffix: ObxValue(
                  (Rx<String> data) => Visibility(
                        visible: data.value != "",
                        child: GestureDetector(
                            onTap: () {
                              controller.clearSearchText();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                      ),
                  controller.searchKeyword)),
          onChanged: (value) {
            controller.inputSearchMemo(value);
          },
        ),
      ),
      body: Obx(
        () => controller.folders.isEmpty
            ? const EmptyFolderScreen()
            : ObxValue(
                (data) => GroupedListView(
                      elements: controller.searchKeyword.value == ""
                          ? controller.memos.toList()
                          : controller.containMemos.toList(),
                      groupBy: (Memo memo) =>
                          controller.getFolderName(memo.folderIdx).folderName,
                      groupSeparatorBuilder: (String group) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: SummaryPanel(
                          widget: Text(
                            group,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ),
                      itemBuilder: (context, Memo memo) => MemoCard(
                          memo: memo,
                          folder: controller.getFolderName(memo.folderIdx)),
                      useStickyGroupSeparators: false,
                      floatingHeader: false,
                    ),
                controller.searchKeyword),
      ),
    );
  }
}

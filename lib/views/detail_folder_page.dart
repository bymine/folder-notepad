import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:memo_sqflite/components/custom_input_field.dart';
import 'package:memo_sqflite/components/empty_folder_screen.dart';
import 'package:memo_sqflite/components/summary_panel.dart';
import 'package:memo_sqflite/constants/color_constants.dart';
import 'package:memo_sqflite/constants/data_constants.dart';
import 'package:memo_sqflite/controllers/detail_folder_controller.dart';
import 'package:memo_sqflite/data_utils.dart';
import 'package:memo_sqflite/models/folder.dart';
import 'package:memo_sqflite/models/memo.dart';

class DetailFolderPage extends GetView<DetailFolderController> {
  const DetailFolderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Obx(() => Text(controller.currentFolder.value.folderName)),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      backgroundColor: scaffoldBackgorund,
                      title: const Text('폴더 삭제'),
                      content: const Text('폴더와 메모를 삭제 하시겠습니까?'),
                      actionsAlignment: MainAxisAlignment.spaceBetween,
                      actions: [
                        TextButton(
                          child: const Text(
                            "취소",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () => Get.back(),
                        ),
                        TextButton(
                          child: const Text(
                            "확인",
                            style: TextStyle(color: headingTextColor),
                          ),
                          onPressed: () {
                            controller.deleteFolder();
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.folder_delete_outlined)),
            IconButton(
                onPressed: () {
                  Get.bottomSheet(
                    const DetailFolderBottomSheet(),
                    backgroundColor: scaffoldBackgorund,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.settings))
          ]),
      body: Obx(
        () => controller.memos.isEmpty
            ? const EmptyFolderScreen()
            : GroupedListView(
                elements: controller.memos.toList(),
                groupBy: (Memo memo) =>
                    DataUtils.dateTimeFormatGroupBy(memo.createdTime),
                groupSeparatorBuilder: (String group) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SummaryPanel(
                      widget: Text(
                    group,
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
                ),
                itemBuilder: (context, Memo memo) => MemoCard(
                  memo: memo,
                  folder: controller.currentFolder.value,
                ),
              ),
      ),
    );
  }
}

class DetailFolderBottomSheet extends GetView<DetailFolderController> {
  const DetailFolderBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          height: Get.height * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "폴더 속성 변경",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.updateFolder();
                          Get.back();
                        }
                      },
                      child: const Text("변경"))
                ],
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              CustomInputField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "폴더명을 입력하세요";
                    } else if (controller.checkDuplicationFolderName(value)) {
                      return "존재하는 폴더명입니다";
                    }
                    return null;
                  },
                  controller: controller.nameController,
                  title: "폴더이름",
                  hintTitle: "폴더이름을 입력하세요"),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("폴더 색상 선택"),
                    Obx(
                      () => Row(
                        children: List.generate(
                            FolderConstants.folderColor.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    controller.changeColor(index);
                                  },
                                  child: AnimatedContainer(
                                    padding: const EdgeInsets.all(8.0),
                                    curve: Curves.ease,
                                    duration: const Duration(seconds: 1),
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor:
                                          controller.selectColor.value == index
                                              ? Colors.white
                                              : Colors.transparent,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor:
                                            FolderConstants.folderColor[index],
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MemoCard extends StatelessWidget {
  final Memo memo;
  final Folder folder;
  const MemoCard({
    required this.memo,
    required this.folder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Card(
        color: cardColor,
        elevation: 2,
        child: ListTile(
            onTap: () {
              Get.toNamed(
                '/detailMemo',
                arguments: [memo, folder],
              );
            },
            title: Text(
              memo.memoTitle,
              maxLines: 1,
            ),
            subtitle: Text(DataUtils.dateTimeFormat(memo.createdTime))),
      ),
    );
  }
}

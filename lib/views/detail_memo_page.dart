import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_sqflite/components/custom_input_field.dart';
import 'package:memo_sqflite/constants/color_constants.dart';
import 'package:memo_sqflite/controllers/detail_memo_controller.dart';

class DetailMemoPage extends GetView<DetailMemoController> {
  const DetailMemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("메모 상세보기"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomInputField(
                  readOnly: true,
                  controller: null,
                  title: "폴더",
                  hintTitle: controller.currentFolder.value.folderName),
              CustomInputField(
                controller: controller.titleEditingController,
                title: "제목",
                hintTitle: "제목을 입력하세요",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "제목을 입력하세요";
                  }
                  return null;
                },
              ),
              CustomInputField(
                controller: controller.bodyEditingController,
                title: "내용",
                hintTitle: "내용을 입력하세요",
                maxLines: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              controller.deleteMemo();
                              Get.back();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "삭제",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ))),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.updateMemo();
                            Get.snackbar(
                              '메모 수정',
                              '메모가 수정되었습니다',
                              snackPosition: SnackPosition.TOP,
                              forwardAnimationCurve: Curves.elasticInOut,
                              reverseAnimationCurve: Curves.easeOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(primary: primaryColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.edit,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("수정"),
                          ],
                        ),
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

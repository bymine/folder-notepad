import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:memo_sqflite/components/custom_input_field.dart';
import 'package:memo_sqflite/constants/color_constants.dart';
import 'package:memo_sqflite/constants/data_constants.dart';
import 'package:memo_sqflite/controllers/add_controller.dart';
import 'package:memo_sqflite/data_utils.dart';
import 'package:memo_sqflite/models/folder.dart';

class AddPage extends GetView<AddController> {
  const AddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          AddMemoButton(formKey: _formKey),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SelectFolderPanel(),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => Visibility(
                    visible: !AddController.to.isExistFolder.value,
                    child: const SelectColorPanel()),
              ),
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
                maxLines: 7,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "내용을 입력하세요";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddMemoButton extends StatelessWidget {
  const AddMemoButton({
    Key? key,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          AddController.to.insertMemo();
          Get.back();
        }
      },
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/svgs/task.svg",
            width: 20,
            height: 20,
            color: headingTextColor,
          ),
          const SizedBox(
            width: 5,
          ),
          const Text(
            "작성",
            style: TextStyle(color: headingTextColor),
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}

class SelectColorPanel extends StatelessWidget {
  const SelectColorPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                          AddController.to.selectColor(index);
                        },
                        child: AnimatedContainer(
                          padding: const EdgeInsets.all(8.0),
                          curve: Curves.ease,
                          duration: const Duration(seconds: 1),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor:
                                AddController.to.selectColorIndex.value == index
                                    ? Colors.grey
                                    : Colors.transparent,
                            child: CircleAvatar(
                              radius: AddController.to.selectColorIndex.value ==
                                      index
                                  ? 11
                                  : 10,
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
    );
  }
}

class SelectFolderPanel extends StatelessWidget {
  const SelectFolderPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("폴더 위치"),
          const SizedBox(
            height: 10,
          ),
          Obx(
            () => TextFormField(
              textAlignVertical: TextAlignVertical.center,
              readOnly: true,
              decoration: InputDecoration(
                hintText: AddController.to.selectedFolder.value,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                    onPressed: () async {
                      Folder? folder = await Get.dialog(
                          const SelectFolderDialog(),
                          arguments: AddController.to.folders);
                      if (folder != null) {
                        AddController.to.selectFolder(folder);
                      }
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: headingTextColor,
                    )),
              ),
              validator: (value) {
                if (AddController.to.selectedFolder.value == "") {
                  return "폴더 위치를 선택해주세요";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SelectFolderDialog extends StatelessWidget {
  const SelectFolderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxList<Folder> dialogFolderList = RxList<Folder>(Get.arguments);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: scaffoldBackgorund,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        width: Get.width * 0.8,
        height: Get.height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "폴더 선택",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Obx(
                    () => Visibility(
                      visible: dialogFolderList.length == Get.arguments.length,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: OutlinedButton(
                          onPressed: () {
                            dialogFolderList.add(Folder(
                                folderSize: 0,
                                folderName: DataUtils.defNewFolderName(
                                    dialogFolderList),
                                folderColor: 5));
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.create_new_folder_outlined,
                                color: headingTextColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "새폴더 생성",
                                style: TextStyle(color: headingTextColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Obx(
                () => GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemCount: dialogFolderList.length,
                    itemBuilder: (context, index) {
                      return CreateFolderCard(
                        folder: dialogFolderList[index],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateFolderCard extends StatelessWidget {
  final Folder folder;
  const CreateFolderCard({Key? key, required this.folder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: folder.folderName);

    return GestureDetector(
      onTap: () {
        if (folder.folderIdx == null) {
          folder.folderName = nameController.text;
        }
        Get.back(result: folder);
      },
      child: Column(
        children: [
          SvgPicture.asset(
            FolderConstants.folderSvg[folder.folderColor],
            width: 30,
            height: 30,
          ),
          TextFormField(
            autofocus: folder.folderIdx == null,
            readOnly: folder.folderIdx != null,
            style: Theme.of(context).textTheme.bodySmall,
            controller: nameController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                border: InputBorder.none, contentPadding: EdgeInsets.zero),
          ),
        ],
      ),
    );
  }
}

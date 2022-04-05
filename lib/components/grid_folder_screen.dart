import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_sqflite/components/folder_card.dart';
import 'package:memo_sqflite/controllers/home_controller.dart';

class GridFolderScreen extends GetView<HomeController> {
  const GridFolderScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: controller.folders.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed('/detailFolder',
                  arguments: controller.folders.toList(),
                  parameters: {"current": index.toString()});
            },
            child: FolderCard(
              folder: controller.folders[index],
            ),
          );
        }));
  }
}

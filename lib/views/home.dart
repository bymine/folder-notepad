import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_sqflite/components/empty_folder_screen.dart';
import 'package:memo_sqflite/components/grid_folder_screen.dart';
import 'package:memo_sqflite/components/search_box.dart';
import 'package:memo_sqflite/components/summary_panel.dart';
import 'package:memo_sqflite/controllers/home_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "내 메모장",
                style: Theme.of(context).textTheme.headline4!,
              ),
              SizedBox(
                height: Get.height * 0.1,
              ),
              const SearchBox(),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Obx(
                () => SummaryPanel(
                  widget: Text(
                    "작성한 글 ${HomeController.to.totalMemo} · 생성한 폴더 ${HomeController.to.totalFolder}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Obx(() => HomeController.to.folders.isEmpty
                  ? const EmptyFolderScreen()
                  : const GridFolderScreen()),
            ],
          ),
        ),
      ),
    );
  }
}

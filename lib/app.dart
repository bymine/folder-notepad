import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_sqflite/components/custom_bottom_appbar.dart';
import 'package:memo_sqflite/controllers/app_controller.dart';
import 'package:memo_sqflite/views/home.dart';
import 'package:memo_sqflite/views/search_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          switch (AppController.to.currentIndex.value) {
            case 0:
              return const Home();

            default:
              return const Search();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add');
        },
        child: const Icon(
          Icons.edit,
        ),
      ),
      floatingActionButtonLocation:
          FixedCenterDockedFabLocation(context: context),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_sqflite/app.dart';
import 'package:memo_sqflite/bindings/init_binding.dart';
import 'package:memo_sqflite/constants/color_constants.dart';
import 'package:memo_sqflite/constants/style_constants.dart';
import 'package:memo_sqflite/controllers/add_controller.dart';
import 'package:memo_sqflite/controllers/detail_folder_controller.dart';
import 'package:memo_sqflite/controllers/detail_memo_controller.dart';
import 'package:memo_sqflite/views/add_page.dart';
import 'package:memo_sqflite/views/detail_folder_page.dart';
import 'package:memo_sqflite/views/detail_memo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '폴더형 메모장',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: scaffoldBackgorund,
        appBarTheme: appBarTheme,
        textTheme: textTheme,
        dividerTheme: dividerTheme,
        bottomNavigationBarTheme: bottomTheme,
        floatingActionButtonTheme: floatingTheme,
      ),
      initialRoute: '/app',
      initialBinding: InitBindings(),
      getPages: [
        GetPage(name: '/', page: () => const App()),
        GetPage(
            name: '/add',
            page: () => const AddPage(),
            binding: BindingsBuilder.put(() => AddController())),
        GetPage(
            name: '/detailFolder',
            page: () => const DetailFolderPage(),
            binding: BindingsBuilder.put(() => DetailFolderController())),
        GetPage(
          name: '/detailMemo',
          page: () => const DetailMemoPage(),
          binding: BindingsBuilder.put(() => DetailMemoController()),
        ),
      ],
    );
  }
}

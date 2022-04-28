import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memo_sqflite/constants/color_constants.dart';
import 'package:memo_sqflite/controllers/app_controller.dart';

class SearchBox extends GetView<AppController> {
  const SearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.changeIndex(1);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: bottomAppbarBackgorund),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search,
                color: Theme.of(context).textTheme.bodySmall!.color),
            const SizedBox(
              width: 10,
            ),
            Text(
              "글 찾기...",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

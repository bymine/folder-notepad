import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:memo_sqflite/constants/color_constants.dart';

class EmptyFolderScreen extends StatelessWidget {
  const EmptyFolderScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: Get.height * 0.05,
        ),
        SvgPicture.asset(
          "assets/svgs/task.svg",
          width: 80,
          color: headingTextColor,
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            "생성한 메모가 없습니다...",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

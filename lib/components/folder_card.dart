import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:memo_sqflite/constants/data_constants.dart';
import 'package:memo_sqflite/models/folder.dart';

class FolderCard extends StatelessWidget {
  final double size;
  final Folder folder;
  const FolderCard({
    Key? key,
    required this.folder,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          FolderConstants.folderSvg[folder.folderColor],
          width: size,
          height: size,
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          folder.folderName,
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          "${folder.folderSize} 작성글",
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}

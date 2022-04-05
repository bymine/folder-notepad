import 'package:intl/intl.dart';
import 'package:memo_sqflite/models/folder.dart';

class DataUtils {
  static String defNewFolderName(List<Folder> folders) {
    int count = 0;
    for (var element in folders) {
      if (element.folderName.contains("새 폴더")) {
        count++;
      }
    }
    if (count == 0) {
      return "새 폴더";
    } else {
      return "새 폴더(${count + 1})";
    }
  }

  static String dateTimeFormatGroupBy(String time) {
    DateTime date = DateTime.parse(time);
    return DateFormat('yyyy-M -d').format(date);
  }

  static String dateTimeFormat(String time) {
    DateTime date = DateTime.parse(time);
    return "등록 날짜 : " + DateFormat('yyyy-M-d  H:mm').format(date);
  }
}

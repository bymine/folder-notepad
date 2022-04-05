class Memo {
  int folderIdx;
  int? memoIdx;
  String memoTitle;
  String memoBody;
  String createdTime;
  String? updateTime;

  Memo(
      {required this.folderIdx,
      required this.memoTitle,
      required this.memoBody,
      required this.createdTime,
      this.memoIdx,
      this.updateTime});

  Map<String, dynamic> toMap() {
    return {
      'folder_id': folderIdx,
      'memo_id': memoIdx,
      'title': memoTitle,
      "body": memoBody,
      "createdTime": createdTime,
      "updatedTime": updateTime
    };
  }

  factory Memo.fromJson(Map<String, dynamic> json) {
    return Memo(
        folderIdx: json['folder_id'],
        memoIdx: json['memo_id'],
        memoTitle: json['title'],
        memoBody: json['body'],
        createdTime: json['createdTime'],
        updateTime: json['updatedTime']);
  }
}

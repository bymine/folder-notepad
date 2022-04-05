class Folder {
  int? folderIdx;
  String folderName;
  int folderColor;
  int folderSize;

  Folder(
      {this.folderIdx,
      required this.folderSize,
      required this.folderName,
      required this.folderColor});

  Map<String, dynamic> toMap() {
    return {'size': folderSize, 'color': folderColor, 'name': folderName};
  }

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
        folderIdx: json['id'],
        folderName: json['name'],
        folderSize: json['size'],
        folderColor: json['color']);
  }
}

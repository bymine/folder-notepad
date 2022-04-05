import 'package:memo_sqflite/models/folder.dart';
import 'package:memo_sqflite/models/memo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper _db = DBHelper._();
  factory DBHelper() => _db;

  static Database? _database;

  static const _databaseName = "memo.db";
  static const _databaseVersion = 1;
  static const _memoTable = "memo";
  static const _folderTable = "folder";

  Future<Database> get database async => _database ??= await _initDB();

  _initDB() async {
    return await openDatabase(join(await getDatabasesPath(), _databaseName),
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_folderTable (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,name TEXT NOT NULL,size INTEGER NOT NULL,color INTEGER NOT NULL)");

    await db.execute(
        "CREATE TABLE $_memoTable (memo_id INTEGER PRIMARY KEY  AUTOINCREMENT NOT NULL,title TEXT NOT NULL, body TEXT NOT NULL, createdTime TEXT NOT NULL, updatedTime TEXT, folder_id INTEGER NOT NULL)");
  }

  Future<int> _addFolder(Folder folder) async {
    final db = await database;
    return await db.insert(_folderTable, folder.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateFolder(Folder folder) async {
    final db = await database;
    return await db.update(_folderTable, folder.toMap(),
        where: "id = ?", whereArgs: [folder.folderIdx]);
  }

  Future<List<Map<String, Object?>>> getAllFolders() async {
    final db = await database;
    return await db.query(_folderTable);
  }

  addMemo(Memo memo, Folder folder, bool isExistFolder) async {
    final db = await database;

    if (isExistFolder) {
      await updateFolder(folder);
    } else {
      memo.folderIdx = await _addFolder(folder);
    }
    await db.insert(_memoTable, memo.toMap());
  }

  updateMemo(Memo memo) async {
    final db = await database;
    return await db.update(_memoTable, memo.toMap(),
        where: "memo_id = ?", whereArgs: [memo.memoIdx]);
  }

  deleteMemo(Memo memo) async {
    final db = await database;
    return await db
        .delete(_memoTable, where: "memo_id = ?", whereArgs: [memo.memoIdx]);
  }

  deleteFolder(Folder folder) async {
    final db = await database;
    await db
        .delete(_memoTable, where: "folder_id = ?", whereArgs: [folder.folderIdx]);

    await db
        .delete(_folderTable, where: "id = ?", whereArgs: [folder.folderIdx]);
  }

  resetAll() async {
    final db = await database;
    db.delete(_folderTable);
    db.delete(_memoTable);
  }

  Future<List<Map<String, Object?>>> getFoldersMemo(Folder folder) async {
    final db = await database;
    return await db.query(_memoTable,
        where: "folder_id = ?", whereArgs: [folder.folderIdx]);
  }

  Future<List<Map<String, Object?>>> getFolder(Folder folder) async {
    final db = await database;
    return await db
        .query(_folderTable, where: "id = ?", whereArgs: [folder.folderIdx]);
  }

  Future<List<Map<String, Object?>>> getAllMemos() async {
    final db = await database;
    return await db.query(_memoTable);
  }
}

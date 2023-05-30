import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = "CheckersMasters.db";
  static const _databaseVersion = 1;

  static const statsTable = 'checkers';

  static const statsId = 'id';
  static const statsName = 'name';
  static const statsAge = 'age';

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $statsTable (
            $statsId INTEGER PRIMARY KEY,
            $statsName TEXT NOT NULL,
            $statsAge INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    return await _db.insert(statsTable, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(statsTable);
  }

  Future<int> queryRowCount() async {
    final results = await _db.rawQuery('SELECT COUNT(*) FROM $statsTable');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  Future<int> update(Map<String, dynamic> row) async {
    int id = row[statsId];
    return await _db.update(
      statsTable,
      row,
      where: '$statsId = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    return await _db.delete(
      statsTable,
      where: '$statsId = ?',
      whereArgs: [id],
    );
  }
}
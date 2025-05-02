import 'package:daxos/entities/remainder.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RemaindersDB{
  static final RemaindersDB instance = RemaindersDB._init();

  static Database? _db;

  RemaindersDB._init();

  Future<Database> get db async {
    if(_db != null) return _db!;

    _db = await _initDB("remainder.db");

    return _db!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB
    );
  }

  Future _createDB(Database db, int version) async {
    final idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    final textTypeNotNull = "TEXT NOT NULL";
    final textType = "TEXT";

    await db.execute(
      '''
        CREATE TABLE $tableRemainders (
          ${RemainderFields.id} $idType,
          ${RemainderFields.name} $textTypeNotNull,
          ${RemainderFields.description} $textTypeNotNull,
          ${RemainderFields.startTs} $textType,
          ${RemainderFields.endTs} $textType
        )
      '''
    );
  }

  Future<Remainder> create(Remainder remainder) async {
    final db = await instance.db;

    final id = await db.insert(tableRemainders, remainder.toJson());

    return remainder.copy(id: id);
  }

  Future<Remainder> readFromId(int id) async {
    final db = await instance.db;

    final maps = await db.query(
      tableRemainders,
      columns: RemainderFields.values,
      where: "${RemainderFields.id} = ?",
      whereArgs: [id]
    );

    if(maps.isNotEmpty) {
      return Remainder.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Remainder>> read() async {
    final db = await instance.db;

    final orderBy = "${RemainderFields.startTs} ASC";

    final res = await db.query(tableRemainders, orderBy: orderBy);

    return res.map((json) => Remainder.fromJson(json)).toList();
  }

  Future<int> update(Remainder remainder) async {
    final db = await instance.db;

    return db.update(
      tableRemainders, 
      remainder.toJson(),
      where: "${RemainderFields.id} = ?",
      whereArgs: [remainder.id]
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.db;

    return await db.delete(
      tableRemainders,
      where: "${RemainderFields.id} = ?",
      whereArgs: [id]
    );
  }

  Future close() async {
    final db = await instance.db;

    db.close();
  }
}
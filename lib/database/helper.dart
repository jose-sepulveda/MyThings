import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const String _databaseName = "study_mate.db";
  static const int _databaseVersion = 1;

  static const String table = 'notes';

  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnContent = 'content';

  //Se crea un constructor privado pa que solo se pueda llamar desde este archivo
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  //El getter encapsula el acceso a la propiedad privada para llamar a _initDatabase si la conexion es nula
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $table (
          $columnId INTEGER PRIMARY KEY, 
          $columnTitle TEXT NOT NULL, 
          $columnContent TEXT NOT NULL
        )
        ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }
}

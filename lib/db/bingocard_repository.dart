import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:bingochart_app/model/bingocard.dart';
import 'package:bingochart_app/model/bingocard_items.dart';

class BingocardRepository {
  static final BingocardRepository instance = BingocardRepository._init();
  static Database? _database;

  BingocardRepository._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bingocards.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    WidgetsFlutterBinding.ensureInitialized();
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 4, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    await db.execute('''
        CREATE TABLE $tableBingocards (
        ${BingocardFields.id} $idType,
        ${BingocardFields.name} $textType
        )
        ''');

    await db.execute('''
      CREATE TABLE $tableBingocardsItems (
      ${BingocardFields.id} $idType,
      ${BingocardItemsFields.idb},
      ${BingocardItemsFields.name},
      FOREIGN KEY (${BingocardItemsFields.idb}) REFERENCES $tableBingocards (${BingocardFields.id})
      )
      ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<Bingocard> create(Bingocard card) async {
    final db = await instance.database;
    final id = await db.insert(tableBingocards, card.toJson());
    for (var i = 0; i < 25; i++) {
      BingocardItems item = BingocardItems(idb: id);
      await db.insert(tableBingocardsItems, item.toJson());
    }
    return card.copy(id: id);
  }

  Future<Bingocard> readBingoCard(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableBingocards,
      columns: BingocardFields.values,
      where: '${BingocardFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Bingocard.fromJson(maps.first);
    }
    throw Exception('ID $id not found');
  }

  Future<List<Bingocard>> readAllBingocards() async {
    final db = await instance.database;

    const orderBy = '${BingocardFields.id} ASC';
    final result = await db.query(tableBingocards, orderBy: orderBy);
    return result.map((json) => Bingocard.fromJson(json)).toList();
  }

  Future<int> update(Bingocard card) async {
    final db = await instance.database;

    return db.update(
      tableBingocards,
      card.toJson(),
      where: '${BingocardFields.id} = ?',
      whereArgs: [card.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return db.delete(
      tableBingocards,
      where: '${BingocardFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<List<BingocardItems>> getItems(int id) async {
    final db = await instance.database;
    print("$id id");
    final result = await db.rawQuery(
        'SELECT * FROM $tableBingocardsItems WHERE ${BingocardItemsFields.idb} = ? LIMIT 25',
        [id]);
    return result.map((json) => BingocardItems.fromJson(json)).toList();
  }

  Future<Future<int>> updateItem(BingocardItems item) async {
    final db = await instance.database;
    return db.update(tableBingocardsItems, item.toJson(),
        where:
            '${BingocardItemsFields.id} = ? AND ${BingocardItemsFields.idb} = ?',
        whereArgs: [item.id, item.idb]);
  }
}

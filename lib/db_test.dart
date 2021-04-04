import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbManager {
  Future<Database> main2() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'bookmark_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE bookmarks(id INTEGER PRIMARY KEY, image TEXT, date TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertbookmark(Database database, Bookmark bookmark) async {
    final Database db = await database;
    await db.insert(
      'bookmarks',
      bookmark.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List> bookmarks(Database database) async {
    final Database db = await database;
    var result = await db.rawQuery("SELECT * FROM bookmarks");
    return result.reversed.toList();
  }

  Future<List> bookmarksids(Database database) async {
    final Database db = await database;
    var result = await db.rawQuery("SELECT id FROM bookmarks");
    return result.reversed.toList();
  }

  // await insertDog(fido);
  // print(await bookmarks());
  Future<void> deleteBM(Database database, int id) async {
    final db = await database;

    await db.delete(
      'bookmarks',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

class Bookmark {
  final int id;
  final String image;
  final String date;

  Bookmark({required this.id, required this.image, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'date': date,
    };
  }
}

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

  Future<List<Bookmark>> bookmarks(Database database) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bookmarks');
    return List.generate(maps.length, (i) {
      return Bookmark(
        id: maps[i]['id'],
        image: maps[i]['image'],
        date: maps[i]['date'],
      );
    });
  }

  // var fido = Bookmark(
  //   id: 0,
  //   image: 'Fido',
  //   date: 'sdgs',
  // );
  // await insertDog(fido);
  // print(await bookmarks());

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

  @override
  String toString() {
    return 'Dog{id: $id, name: $image, age: $date}';
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/task_model.dart';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE Task(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        taskStatus Text
      )
      """);
  }

  static Future<sql.Database> _initialDB() async {
    return sql.openDatabase(
      'task.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (journal)
  static Future<int> createItem(
      String title, String? descrption, String taskStatus) async {
    final db = await SQLHelper._initialDB();

    final data = {
      'title': title,
      'description': descrption,
      'taskStatus': taskStatus
    };
    final id = await db.insert('Task', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  // Read all items (journals)
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper._initialDB();
    return db.query('Task', orderBy: "id");
  }

  // Read a single item by id
  // The app doesn't use this method but I put here in case you want to see it
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper._initialDB();
    return db.query('Task', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItemDescription(int id, String? description) async {
    final db = await SQLHelper._initialDB();

    final data = {
      'description': description,
    };

    final result =
        await db.update('Task', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<int> updateItemStatus(int id, Status taskStatus) async {
    final db = await SQLHelper._initialDB();

    final data = {
      'taskStatus': taskStatus,
    };

    final result =
        await db.update('Task', data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper._initialDB();
    try {
      await db.delete("Task", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}

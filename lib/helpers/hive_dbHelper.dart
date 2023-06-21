import 'package:Canban/models/task_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {

  static Future<Box> initialThemeDb() async{
    final dbDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(dbDir.path);

    var box = await Hive.openBox('darkModeBox');

    return box;
  }

  static Future<Box> initialDB() async {
    final dbDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(dbDir.path);

    //? If adapter required use this block
    // if (!Hive.isAdapterRegistered(0)) {
    //   Hive.registerAdapter(TaskAdapter());
    // }

    var box = await Hive.openBox<Task>('taskBox');

    return box;
  }

  static Future<void> addItem(Task item) async {
    var box = await initialDB();
    await box.add(item);

    // print('************** Item added in database ***********');
  }
  static Future<void> getItem(int id) async {
    var box = await initialDB();
    await box.get(id);

    // print('******id**$id*********');
  }

  static Future<List<Task>> getAllItems() async {
    List<Task> items = [];
    var box = await initialDB();

    for (var item in box.values) {
      items.add(item);
    }
    return items;
  }

  // Update an item by id
  static Future<void> updateItemDescription(int id, String? description) async {
    var box = await initialDB();
    final task = box.get(id);
    task.description = description;
    task.save();

    // print('******task desc updated**$task*********');
  }

  static Future<void> updateItemStatus(Task task, Status taskStatus) async {
    var box = await initialDB();
    final task = box.get('task');
    task.status = taskStatus;
    task.save();

    // print('******task status updated**$task*********');
  }

  // Delete
  static Future<void> deleteItem(dynamic id) async {
    var box = await initialDB();
    await box.delete(id);

    // print('************** Item deleted in database ***********');
  }
}

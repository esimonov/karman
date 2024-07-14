import 'package:sqflite/sqflite.dart';

class TaskDatabase {
  final String tableName = 'tasks';

  Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXISTS $tableName (
        task_id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        note TEXT,
        priority INTEGER NOT NULL,
        due_date TEXT,
        reminder TEXT,
        is_completed INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  // CRUD operations for tasks
  Future<int> createTask(Database db, Map<String, dynamic> task) async {
    return await db.insert(tableName, task);
  }

  Future<List<Map<String, dynamic>>> getTasks(Database db) async {
    return await db.query(tableName);
  }

  Future<int> updateTask(Database db, Map<String, dynamic> task) async {
    return await db.update(
      tableName,
      task,
      where: 'task_id = ?',
      whereArgs: [task['task_id']],
    );
  }

  Future<int> deleteTask(Database db, int id) async {
    return await db.delete(
      tableName,
      where: 'task_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCompletedTasks(Database db) async {
    return await db.delete(
      tableName,
      where: 'is_completed = ?',
      whereArgs: [1],
    );
  }
}

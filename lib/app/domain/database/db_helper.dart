import 'package:note_flow/app/domain/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static const int _version = 1;
  static const String _dbName = 'Notes.db';

  static Future<Database> _getDB() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      version: _version,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE Note(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL, date TEXT NOT NULL)",
        );
      },
    );
  }

  static Future<int> addNote(NoteModel noteModel) async {
    final db = await _getDB();
    return await db.insert(
      "Note",
      noteModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> updateNote(NoteModel noteModel) async {
    final db = await _getDB();
    return await db.update(
      "Note",
      noteModel.toJson(),
      where: 'id = ?',
      whereArgs: [noteModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> deleteNote(NoteModel noteModel) async {
    final db = await _getDB();
    return await db.delete(
      "Note",
      where: 'id = ?',
      whereArgs: [noteModel.id],
    );
  }

  static Future<List<NoteModel>?> getAllNote() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Note");

    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
      maps.length,
      (index) => NoteModel.fromJson(
        maps[index],
      ),
    );
  }
}

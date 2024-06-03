import 'package:note_flow/app/domain/models/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static const int _version = 2;
  static const String _dbName = 'Notes';

  Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        version: _version, onCreate: (db, version) async {
      await db.execute(
        "CREATE TABLE Note(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL, pinned INTEGER NOT NULL DEFAULT 0);",
      );
    }, onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 2) {
        await db.execute("DROP TABLE IF EXISTS Note");
        await db.execute(
          "CREATE TABLE Note(id INTEGER PRIMARY KEY, title TEXT NOT NULL, description TEXT NOT NULL, pinned INTEGER NOT NULL DEFAULT 0);",
        );
      }
    });
  }

  Future<int> addNote(NoteModel noteModel) async {
    final db = await _getDB();
    return await db.insert(
      "Note",
      noteModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateNote(NoteModel noteModel) async {
    final db = await _getDB();
    return await db.update(
      "Note",
      noteModel.toJson(),
      where: 'id = ?',
      whereArgs: [noteModel.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteNote(NoteModel noteModel) async {
    final db = await _getDB();
    return await db.delete(
      "Note",
      where: 'id = ?',
      whereArgs: [noteModel.id],
    );
  }

  Future<List<NoteModel>> getAllNotes() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query("Note");

    if (maps.isEmpty) {
      return [];
    }

    return List.generate(
      maps.length,
      (index) => NoteModel.fromJson(
        maps[index],
      ),
    );
  }

  Future<void> close() async {
    final db = await _getDB();
    return db.close();
  }
}

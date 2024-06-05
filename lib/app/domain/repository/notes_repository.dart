import 'package:note_flow/app/domain/database/db_helper.dart';
import 'package:note_flow/app/domain/models/note_model.dart';

class NoteRepository {
  final DBHelper _dbHelper;

  NoteRepository(this._dbHelper);

  Future<List<NoteModel>> searchNotes(String query) {
    return _dbHelper.searchNotes(query);
  }

  Future<List<NoteModel>> getAllNotes() {
    return _dbHelper.getAllNotes();
  }

  Future<int> addNote(NoteModel note) {
    return _dbHelper.addNote(note);
  }

  Future<int> updateNote(NoteModel note) {
    return _dbHelper.updateNote(note);
  }

  Future<int> deleteNote(NoteModel note) {
    return _dbHelper.deleteNote(note);
  }
}

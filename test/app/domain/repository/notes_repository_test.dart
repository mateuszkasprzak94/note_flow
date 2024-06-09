import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:note_flow/app/domain/database/db_helper.dart';
import 'package:note_flow/app/domain/models/note_model.dart';
import 'package:note_flow/app/domain/repository/notes_repository.dart';

class MockDBHelper extends Mock implements DBHelper {}

void main() {
  late NoteRepository sut;
  late DBHelper databaseHelper;

  setUp(() {
    databaseHelper = MockDBHelper();
    sut = NoteRepository(databaseHelper);
  });

  group('getAllNotes', () {
    test('should return a list of notes', () async {
      // Arrange
      when(() => databaseHelper.getAllNotes()).thenAnswer((_) async => []);
      // Act
      final result = await sut.getAllNotes();
      // Assert
      expect(result, isEmpty);
    });
  });

  test('should search for a note', () async {
    // Arrange
    when(() => databaseHelper.searchNotes('test')).thenAnswer(
      (_) async => [
        const NoteModel(title: 'test', description: 'test'),
        const NoteModel(title: 'test1', description: 'test1'),
        const NoteModel(title: 'test2', description: 'test2'),
      ],
    );
    // Act
    final results = await sut.searchNotes('test');
    // Assert
    expect(results.length, 3);
  });

  test('should add a note', () async {
    // Arrange
    const note = NoteModel(title: 'title', description: 'description');
    when(() => databaseHelper.addNote(note)).thenAnswer((_) async => 1);
    // Act
    final result = await sut.addNote(note);
    // Assert
    expect(result, 1);
  });

  test('should update a note', () async {
    // Arrange
    const note = NoteModel(title: 'title', description: 'description');
    when(() => databaseHelper.updateNote(note)).thenAnswer((_) async => 1);
    // Act
    final result = await sut.updateNote(note);
    // Assert
    expect(result, 1);
  });

  test('should delete a note', () async {
    // Arrange
    const note = NoteModel(title: 'title', description: 'description');
    when(() => databaseHelper.deleteNote(note)).thenAnswer((_) async => 1);
    // Act
    final result = await sut.deleteNote(note);
    // Assert
    expect(result, 1);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:note_flow/app/core/enums.dart';
import 'package:note_flow/app/domain/models/note_model.dart';
import 'package:note_flow/app/domain/repository/notes_repository.dart';
import 'package:note_flow/app/features/add_note/cubit/add_note_cubit.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

void main() {
  late AddNoteCubit cubit;
  late MockNoteRepository repository;

  setUp(() {
    repository = MockNoteRepository();
    cubit = AddNoteCubit(repository);
  });

  group('AddNoteCubit', () {
    group('addOrUpdate', () {
      const newNote =
          NoteModel(title: 'New Note', description: 'New description');
      const existingNote = NoteModel(
          id: 1, title: 'Existing Note', description: 'Existing description');

      test('emits success state when adding a new note succeeds', () async {
        when(() => repository.addNote(newNote)).thenAnswer((_) async => 1);

        expectLater(
          cubit.stream,
          emitsInOrder([
            AddNoteState(
              status: Status.success,
            ),
          ]),
        );

        await cubit.addOrUpdate(newNote);

        verify(() => repository.addNote(newNote)).called(1);
      });

      test('emits success state when updating an existing note succeeds',
          () async {
        when(() => repository.updateNote(existingNote))
            .thenAnswer((_) async => 1);

        expectLater(
          cubit.stream,
          emitsInOrder([
            AddNoteState(
              status: Status.success,
            ),
          ]),
        );

        await cubit.addOrUpdate(existingNote);

        verify(() => repository.updateNote(existingNote)).called(1);
      });

      test('emits error state when adding a new note fails', () async {
        final exception = Exception('Failed to add note');
        when(() => repository.addNote(newNote)).thenThrow(exception);

        expectLater(
          cubit.stream,
          emitsInOrder([
            AddNoteState(
              status: Status.error,
              errorMessage: exception.toString(),
            ),
          ]),
        );

        await cubit.addOrUpdate(newNote);

        verify(() => repository.addNote(newNote)).called(1);
      });

      test('emits error state when updating an existing note fails', () async {
        final exception = Exception('Failed to update note');
        when(() => repository.updateNote(existingNote)).thenThrow(exception);

        expectLater(
          cubit.stream,
          emitsInOrder([
            AddNoteState(
              status: Status.error,
              errorMessage: exception.toString(),
            ),
          ]),
        );

        await cubit.addOrUpdate(existingNote);

        verify(() => repository.updateNote(existingNote)).called(1);
      });
    });
  });
}

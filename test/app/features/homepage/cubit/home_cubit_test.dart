import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:note_flow/app/core/enums.dart';
import 'package:note_flow/app/domain/models/note_model.dart';
import 'package:note_flow/app/domain/repository/notes_repository.dart';
import 'package:note_flow/app/features/homepage/cubit/home_cubit.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

void main() {
  late HomeCubit sut;
  late MockNoteRepository repository;

  setUp(() {
    repository = MockNoteRepository();
    sut = HomeCubit(repository);
  });

  group('start', () {
    group('success', () {
      setUp(() {
        when(() => repository.getAllNotes()).thenAnswer(
          (_) async => [
            const NoteModel(title: 'title', description: 'description'),
            const NoteModel(title: 'title1', description: 'description1'),
          ],
        );
      });

      blocTest<HomeCubit, HomeState>(
        'emit Status.loading then Status.success with results',
        build: () => sut,
        act: (cubit) => cubit.start(),
        expect: () => [
          HomeState(
            status: Status.loading,
          ),
          HomeState(
            status: Status.success,
            items: [
              const NoteModel(title: 'title', description: 'description'),
              const NoteModel(title: 'title1', description: 'description1'),
            ],
            pinnedNotes: [],
            otherNotes: [
              const NoteModel(title: 'title', description: 'description'),
              const NoteModel(title: 'title1', description: 'description1'),
            ],
          ),
        ],
      );
    });

    group('failure', () {
      setUp(() {
        when(() => repository.getAllNotes())
            .thenThrow(Exception('test-exception-error'));
      });

      blocTest('emit Status.loading then Status.error with error message',
          build: () => sut,
          act: (cubit) => cubit.start(),
          expect: () => [
                HomeState(
                  status: Status.loading,
                ),
                HomeState(
                  status: Status.error,
                  errorMessage: 'Exception: test-exception-error',
                ),
              ]);
    });
  });

  group('delete', () {
    group('success', () {
      const note = NoteModel(title: 'title', description: 'description');
      setUp(() {
        when(() => repository.deleteNote(note)).thenAnswer((_) async => 1);
        when(() => repository.getAllNotes()).thenAnswer((_) async => []);
      });

      blocTest<HomeCubit, HomeState>(
        'emit Status.loading then Status.success with results',
        build: () => sut,
        act: (cubit) => cubit.delete(note),
        expect: () => [
          HomeState(
            status: Status.loading,
          ),
          HomeState(
            status: Status.success,
            items: [],
            pinnedNotes: [],
            otherNotes: [],
          ),
        ],
      );
    });

    group('failure', () {
      const note = NoteModel(title: 'title', description: 'description');
      setUp(() {
        when(() => repository.deleteNote(note))
            .thenThrow(Exception('test-exception-error'));
      });

      blocTest(
        'emit Status.error with error message',
        build: () => sut,
        act: (cubit) => cubit.delete(note),
        expect: () => [
          HomeState(
            status: Status.error,
            errorMessage: 'Exception: test-exception-error',
          ),
        ],
      );
    });
  });

  group('searchNotes', () {
    group('success', () {
      setUp(() {
        when(() => repository.searchNotes('test')).thenAnswer(
          (_) async => [
            const NoteModel(
              title: 'test',
              description: 'test',
            ),
            const NoteModel(title: 'test1', description: 'test1'),
            const NoteModel(title: 'test2', description: 'test2'),
          ],
        );
      });

      blocTest(
        'emit Status.loading then Status.success with results',
        build: () => sut,
        act: (cubit) => cubit.searchNotes('test'),
        expect: () => [
          HomeState(
            status: Status.loading,
          ),
          HomeState(
            status: Status.success,
            items: [
              const NoteModel(title: 'test', description: 'test'),
              const NoteModel(title: 'test1', description: 'test1'),
              const NoteModel(title: 'test2', description: 'test2'),
            ],
            pinnedNotes: [],
            otherNotes: [
              const NoteModel(title: 'test', description: 'test'),
              const NoteModel(title: 'test1', description: 'test1'),
              const NoteModel(title: 'test2', description: 'test2'),
            ],
          ),
        ],
      );
    });

    group('filterByTag', () {
      const tag = 'inspirationTag';
      const noteWithInspirationTag = NoteModel(
          title: 'title1', description: 'desc1', inspirationTag: true);
      const noteWithoutInspirationTag =
          NoteModel(title: 'title2', description: 'desc2');

      group('success', () {
        setUp(() {
          when(() => repository.getAllNotes()).thenAnswer(
            (_) async => [
              noteWithInspirationTag,
              noteWithoutInspirationTag,
            ],
          );
        });

        blocTest<HomeCubit, HomeState>(
          'emits Status.loading then Status.success with filtered notes',
          build: () => sut,
          act: (cubit) => cubit.filterByTag(tag),
          expect: () => [
            HomeState(
              status: Status.loading,
            ),
            HomeState(
              status: Status.success,
              items: [
                noteWithInspirationTag,
              ],
              pinnedNotes: [],
              otherNotes: [
                noteWithInspirationTag,
              ],
            ),
          ],
        );
      });

      group('failure', () {
        setUp(() {
          when(() => repository.getAllNotes()).thenThrow(
            Exception('test-exception-error'),
          );
        });

        blocTest<HomeCubit, HomeState>(
          'emits Status.loading then Status.error with error message',
          build: () => sut,
          act: (cubit) => cubit.filterByTag(tag),
          expect: () => [
            HomeState(
              status: Status.loading,
            ),
            HomeState(
              status: Status.error,
              errorMessage: 'Exception: test-exception-error',
            ),
          ],
        );
      });
    });
  });
}

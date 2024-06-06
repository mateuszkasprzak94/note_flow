import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note_flow/app/core/enums.dart';
import 'package:note_flow/app/domain/models/note_model.dart';
import 'package:note_flow/app/domain/repository/notes_repository.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._noteRepository) : super(HomeState());

  final NoteRepository _noteRepository;

  Future<void> start() async {
    emit(
      HomeState(
        items: [],
        status: Status.loading,
        errorMessage: '',
      ),
    );
    try {
      final results = await _noteRepository.getAllNotes();
      final pinnedNotes = results.where((note) => note.pinned == 1).toList();
      final otherNotes = results.where((note) => note.pinned == 0).toList();
      emit(
        HomeState(
          items: results,
          pinnedNotes: pinnedNotes,
          otherNotes: otherNotes,
          status: Status.success,
          errorMessage: '',
        ),
      );
    } catch (error) {
      emit(
        HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> delete(NoteModel noteModel) async {
    try {
      await _noteRepository.deleteNote(noteModel);
      final updatedNotes =
          state.items.where((note) => note.id != noteModel.id).toList();
      final pinnedNotes =
          updatedNotes.where((note) => note.pinned == 1).toList();
      final otherNotes =
          updatedNotes.where((note) => note.pinned == 0).toList();
      emit(
        state.copyWith(
          items: updatedNotes,
          pinnedNotes: pinnedNotes,
          otherNotes: otherNotes,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(
        HomeState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> searchNotes(String query) async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    try {
      final notes = await _noteRepository.searchNotes(query);
      final pinnedNotes = notes.where((note) => note.pinned == 1).toList();
      final otherNotes = notes.where((note) => note.pinned == 0).toList();

      emit(
        state.copyWith(
          items: notes,
          pinnedNotes: pinnedNotes,
          otherNotes: otherNotes,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> filterByTag(String tag) async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    try {
      final notes = await _noteRepository.getAllNotes();

      List<NoteModel> filteredNotes;
      if (tag == 'inspirationTag') {
        filteredNotes = notes.where((note) => note.inspirationTag).toList();
      } else if (tag == 'personalTag') {
        filteredNotes =
            notes.where((note) => note.personalTag == true).toList();
      } else if (tag == 'workTag') {
        filteredNotes = notes.where((note) => note.workTag).toList();
      } else {
        filteredNotes = notes;
      }
      emit(
        state.copyWith(
          items: filteredNotes,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}

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

  Future<void> _loadNotes() async {
    emit(
      state.copyWith(
        status: Status.loading,
      ),
    );
    try {
      final results = await _noteRepository.getAllNotes();
      _updateStateWithNotes(results);
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  void _updateStateWithNotes(List<NoteModel> notes) {
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
  }

  Future<void> start() async {
    _loadNotes();
  }

  Future<void> delete(NoteModel noteModel) async {
    try {
      await _noteRepository.deleteNote(noteModel);
      _loadNotes();
    } catch (error) {
      emit(
        state.copyWith(
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
      _updateStateWithNotes(notes);
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
      final filteredNotes = _filterNotesByTag(notes, tag);
      _updateStateWithNotes(filteredNotes);
    } catch (error) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  List<NoteModel> _filterNotesByTag(List<NoteModel> notes, String tag) {
    if (tag == 'inspirationTag') {
      return notes.where((note) => note.inspirationTag).toList();
    } else if (tag == 'personalTag') {
      return notes.where((note) => note.personalTag).toList();
    } else if (tag == 'workTag') {
      return notes.where((note) => note.workTag).toList();
    }
    return notes;
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note_flow/app/core/enums.dart';
import 'package:note_flow/app/domain/database/db_helper.dart';
import 'package:note_flow/app/domain/models/note_model.dart';

part 'add_note_state.dart';
part 'add_note_cubit.freezed.dart';

class AddNoteCubit extends Cubit<AddNoteState> {
  AddNoteCubit(this.dbHelper) : super(AddNoteState());

  final DBHelper dbHelper;

  Future<void> addOrUpdate(NoteModel noteModel) async {
    try {
      if (noteModel.id == null) {
        // If the note ID is null, it means it's a new note
        await dbHelper.addNote(noteModel);
      } else {
        // Otherwise, it's an existing note that needs to be updated
        await dbHelper.updateNote(noteModel);
      }
      emit(
        AddNoteState(
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(
        AddNoteState(
          status: Status.error,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}

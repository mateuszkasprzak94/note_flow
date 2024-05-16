import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:note_flow/app/core/enums.dart';
import 'package:note_flow/app/domain/database/db_helper.dart';
import 'package:note_flow/app/domain/models/note_model.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.dbHelper}) : super(HomeState());

  final DBHelper dbHelper;

  Future<void> start() async {
    emit(
      HomeState(
        items: [],
        status: Status.loading,
        errorMessage: '',
      ),
    );
    try {
      final results = await dbHelper.getAllNotes();
      emit(
        HomeState(
          items: results,
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
      await dbHelper.deleteNote(noteModel);
      final updatedNotes =
          state.items.where((note) => note.id != noteModel.id).toList();
      emit(
        state.copyWith(
          items: updatedNotes,
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
}

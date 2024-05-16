part of 'add_note_cubit.dart';

@freezed
class AddNoteState with _$AddNoteState {
  factory AddNoteState({
    @Default(Status.initial) status,
    String? errorMessage,
  }) = _AddNoteState;
}

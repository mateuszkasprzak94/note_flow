part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default([]) List<NoteModel> items,
    @Default(Status.initial) status,
    String? errorMessage,
  }) = _HomeState;
}

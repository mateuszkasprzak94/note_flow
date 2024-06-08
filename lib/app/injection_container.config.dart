// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:note_flow/app/domain/database/db_helper.dart' as _i3;
import 'package:note_flow/app/domain/repository/notes_repository.dart' as _i4;
import 'package:note_flow/app/features/add_note/cubit/add_note_cubit.dart'
    as _i5;
import 'package:note_flow/app/features/homepage/cubit/home_cubit.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.DBHelper>(() => _i3.DBHelper());
    gh.factory<_i4.NoteRepository>(
        () => _i4.NoteRepository(gh<_i3.DBHelper>()));
    gh.factory<_i5.AddNoteCubit>(
        () => _i5.AddNoteCubit(gh<_i4.NoteRepository>()));
    gh.factory<_i6.HomeCubit>(() => _i6.HomeCubit(gh<_i4.NoteRepository>()));
    return this;
  }
}

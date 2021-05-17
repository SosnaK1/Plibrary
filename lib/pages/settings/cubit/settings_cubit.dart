import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plibrary/database_service/database_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._databaseRepository) : super(SettingsInitial());

  final DatabaseRepository _databaseRepository;

  void removeMoviesData() {
    _databaseRepository.removeAllMovies();
  }

  void removeSeriesData() {
    _databaseRepository.removeAllSeries();
  }

  void removeBooksData() {
    _databaseRepository.removeAllBooks();
  }

  void removeGamesData() {
    _databaseRepository.removeAllGames();
  }

  void removeAllData() {
    _databaseRepository.removeAllData();
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models.dart';

part 'games_state.dart';

class GamesCubit extends Cubit<GamesState> {
  GamesCubit(this._databaseRepository)
      : super(GamesState(gamesStream: _databaseRepository.getGames()));

  final DatabaseRepository _databaseRepository;

  void deleteMovieFromDB(Game game) async {
    _databaseRepository.deleteItem(game);
  }

  void searchFilterChanged(String value) {
    emit(state.copyWith(searchFilter: value));
  }
}

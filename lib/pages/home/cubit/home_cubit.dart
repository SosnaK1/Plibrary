import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._databaseRepository)
      : super(HomeState(
            moviesStream: _databaseRepository.getMovies(),
            seriesStream: _databaseRepository.getSeries(),
            booksStream: _databaseRepository.getBooks(),
            gamesStream: _databaseRepository.getGames()));

  final DatabaseRepository _databaseRepository;
}

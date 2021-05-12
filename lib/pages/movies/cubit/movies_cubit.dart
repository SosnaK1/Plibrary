import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models/movie.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this._databaseRepository) : super(MoviesState(moviesStream: _databaseRepository.getMovies()));

  final DatabaseRepository _databaseRepository;

  void deleteMovieFromDB(Movie movie) async {
    print("deleting...");
    _databaseRepository.deleteMovie(movie);
  }
}

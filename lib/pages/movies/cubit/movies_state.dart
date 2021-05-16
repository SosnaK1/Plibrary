part of 'movies_cubit.dart';

class MoviesState extends Equatable {
  const MoviesState({this.moviesStream, this.searchFilter = ""});

  final Stream<List<Movie>> moviesStream;
  final String searchFilter;

  @override
  List<Object> get props => [moviesStream, searchFilter];

  MoviesState copyWith(
      {Stream<List<Movie>> moviesStream, String searchFilter}) {
    return MoviesState(
        moviesStream: moviesStream ?? this.moviesStream,
        searchFilter: searchFilter ?? this.searchFilter);
  }
}

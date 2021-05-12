part of 'movies_cubit.dart';

class MoviesState extends Equatable {
  const MoviesState({this.moviesStream});

  final Stream<List<Movie>> moviesStream;

  @override
  List<Object> get props => [moviesStream];
}
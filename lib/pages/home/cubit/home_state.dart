part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState(
      {this.moviesStream,
      this.seriesStream,
      this.booksStream,
      this.gamesStream});

  final Stream<List<Movie>> moviesStream;
  final Stream<List<Series>> seriesStream;
  final Stream<List<Book>> booksStream;
  final Stream<List<Game>> gamesStream;

  @override
  List<Object> get props =>
      [moviesStream, seriesStream, booksStream, gamesStream];
}

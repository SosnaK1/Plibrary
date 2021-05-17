part of 'games_cubit.dart';

class GamesState extends Equatable {
  const GamesState({this.gamesStream, this.searchFilter = ""});

  final Stream<List<Game>> gamesStream;
  final String searchFilter;

  @override
  List<Object> get props => [gamesStream, searchFilter];

  GamesState copyWith(
      {Stream<List<Game>> gamesStream, String searchFilter}) {
    return GamesState(
        gamesStream: gamesStream ?? this.gamesStream,
        searchFilter: searchFilter ?? this.searchFilter);
  }
}

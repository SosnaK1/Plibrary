part of 'series_cubit.dart';

class SeriesState extends Equatable {
  const SeriesState({this.seriesStream, this.searchFilter = ""});

  final Stream<List<Series>> seriesStream;
  final String searchFilter;

  @override
  List<Object> get props => [seriesStream, searchFilter];

  SeriesState copyWith(
      {Stream<List<Series>> seriesStream, String searchFilter}) {
    return SeriesState(
        seriesStream: seriesStream ?? this.seriesStream,
        searchFilter: searchFilter ?? this.searchFilter);
  }
}

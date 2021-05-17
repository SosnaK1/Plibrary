import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models/series.dart';

part 'series_state.dart';

class SeriesCubit extends Cubit<SeriesState> {
  SeriesCubit(this._databaseRepository)
      : super(SeriesState(seriesStream: _databaseRepository.getSeries()));

  final DatabaseRepository _databaseRepository;

  void deleteSeriesFromDB(Series series) async {
    _databaseRepository.deleteItem(series);
  }

  void searchFilterChanged(String value) {
    emit(state.copyWith(searchFilter: value));
  }
}

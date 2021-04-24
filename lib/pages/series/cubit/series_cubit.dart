import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'series_state.dart';

class SeriesCubit extends Cubit<SeriesState> {
  SeriesCubit() : super(SeriesInitial());
}

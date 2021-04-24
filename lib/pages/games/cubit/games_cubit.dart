import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'games_state.dart';

class GamesCubit extends Cubit<GamesState> {
  GamesCubit() : super(GamesInitial());
}

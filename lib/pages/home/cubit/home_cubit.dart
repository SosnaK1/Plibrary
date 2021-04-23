import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._authenticationRepository) : super(HomeState(user: _authenticationRepository.currentUser));

  final AuthenticationRepository _authenticationRepository;
}

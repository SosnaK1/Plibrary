import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotAnonymous
              ? AppState.authenticated(authenticationRepository.currentUser)
              : const AppState.unauthenticated(),
        ) {
    _userSubscription = _authenticationRepository.user.listen(_onUserChanged);
  }

  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<User> _userSubscription;

  void _onUserChanged(User user) => add(AppUserChanged(user));

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AppUserChanged) {
      yield _mapUserChangedToState(event, state);
    } else if (event is AppLogoutRequested) {
      _authenticationRepository.logOut();
    } else if (event is AppUserDeleteRequested) {
      _authenticationRepository.deleteUser();
    }
  }

  AppState _mapUserChangedToState(AppUserChanged event, AppState state) {
    return event.user.isNotAnonymous
        ? AppState.authenticated(event.user)
        : const AppState.unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}

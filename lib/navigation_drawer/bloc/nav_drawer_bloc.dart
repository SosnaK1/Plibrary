import 'dart:math';

import 'package:bloc/bloc.dart';

import 'nav_drawer_event.dart';
import 'nav_drawer_state.dart';

class NavDrawerBloc extends Bloc<NavDrawerEvent, NavDrawerState> {
  NavDrawerBloc() : super(NavDrawerState(NavItem.home));

  @override
  Stream<NavDrawerState> mapEventToState(NavDrawerEvent event) async* {
    if (event is NavigateTo) {
      if (event.destination != state.selectedItem) {
        yield NavDrawerState(event.destination);
      }
    } else if (event is ChangeSortOption) {
      if (event.sortOption != state.sortOption) {
        yield NavDrawerState(state.selectedItem,
            sortOption: event.sortOption,
            searchFieldRevealed: state.searchFieldRevealed);
      }
    } else if (event is ChangeSearchFieldVisibility) {
      yield NavDrawerState(state.selectedItem,
          sortOption: state.sortOption,
          searchFieldRevealed: !state.searchFieldRevealed);
    }
  }
}

import 'package:plibrary/utils/item_sort_utils.dart';

import 'nav_drawer_state.dart';

abstract class NavDrawerEvent {
  const NavDrawerEvent();
}

class NavigateTo extends NavDrawerEvent {
  final NavItem destination;
  const NavigateTo(this.destination);
}

class ChangeSortOption extends NavDrawerEvent {
  final ItemSortOption sortOption;
  const ChangeSortOption(this.sortOption);
}
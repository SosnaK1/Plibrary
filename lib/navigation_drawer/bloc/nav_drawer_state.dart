import 'package:plibrary/utils/item_sort_utils.dart';

class NavDrawerState {
  NavDrawerState(this.selectedItem,
      {this.sortOption = ItemSortOption.ScoreDec});

  final NavItem selectedItem;
  final ItemSortOption sortOption;
}

enum NavItem { home, movies, series, books, games, settings }

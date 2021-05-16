import 'package:plibrary/utils/item_sort_utils.dart';

class NavDrawerState {
  NavDrawerState(this.selectedItem,
      {this.sortOption = ItemSortOption.ScoreDec,
      this.searchFieldRevealed = false});

  final NavItem selectedItem;
  final ItemSortOption sortOption;
  final bool searchFieldRevealed;
}

enum NavItem { home, movies, series, books, games, settings }

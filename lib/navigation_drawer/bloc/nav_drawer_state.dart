class NavDrawerState {
  final NavItem selectedItem;
  const NavDrawerState(this.selectedItem);
}

enum NavItem {
  home,
  movies,
  series,
  books,
  games,
  settings
}
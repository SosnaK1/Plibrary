import 'package:plibrary/navigation_drawer/navigation_drawer.dart';

String getItemTypeName(NavItem item) {
  switch (item) {
    case NavItem.home:
      return "Home";
      break;
    case NavItem.movies:
      return "Movies";
      break;
    case NavItem.series:
      return "Series";
      break;
    case NavItem.books:
      return "Books";
      break;
    case NavItem.games:
      return "Games";
      break;
    case NavItem.settings:
      return "Settings";
      break;
    default:
      return "";
  }
}

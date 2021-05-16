import 'package:plibrary/database_service/models/library_item.dart';

enum ItemSortOption { NameInc, NameDec, ScoreInc, ScoreDec, DateInc, DateDec }

int Function(LibraryItem, LibraryItem) getSortingFunction(
    ItemSortOption sortOption) {
  switch (sortOption) {
    case ItemSortOption.NameInc:
      return (LibraryItem a, LibraryItem b) => b.title.compareTo(a.title);
    case ItemSortOption.NameDec:
      return (LibraryItem a, LibraryItem b) => a.title.compareTo(b.title);
    case ItemSortOption.ScoreInc:
      return (LibraryItem a, LibraryItem b) => a.score.compareTo(b.score);
    case ItemSortOption.ScoreDec:
      return (LibraryItem a, LibraryItem b) => b.score.compareTo(a.score);
    case ItemSortOption.DateInc:
      return (LibraryItem a, LibraryItem b) =>
          a.timeAdded.compareTo(b.timeAdded);
    case ItemSortOption.DateDec:
      return (LibraryItem a, LibraryItem b) =>
          b.timeAdded.compareTo(a.timeAdded);
  }
  return null;
}

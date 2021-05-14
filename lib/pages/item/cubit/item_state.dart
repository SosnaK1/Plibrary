part of 'item_cubit.dart';

class ItemState extends Equatable {
  const ItemState(
      {this.item,
      this.formModified = false,
      this.dialogTitle,
      this.dialogAuthor,
      this.dialogGenre,
      this.dialogDescription});

  final LibraryItem item;
  final bool formModified;

  final String dialogTitle;
  final String dialogAuthor;
  final String dialogGenre;
  final String dialogDescription;

  @override
  List<Object> get props => [
        item,
        formModified,
        dialogTitle,
        dialogAuthor,
        dialogGenre,
        dialogDescription
      ];

  ItemState copyWith(
      {LibraryItem item,
      bool formModified,
      String dialogTitle,
      String dialogAuthor,
      String dialogGenre,
      String dialogDescription}) {
    return ItemState(
        item: item ?? this.item,
        formModified: formModified ?? this.formModified,
        dialogTitle: dialogTitle ?? this.dialogTitle,
        dialogAuthor: dialogAuthor ?? this.dialogAuthor,
        dialogGenre: dialogGenre ?? this.dialogGenre,
        dialogDescription: dialogDescription ?? this.dialogDescription);
  }
}

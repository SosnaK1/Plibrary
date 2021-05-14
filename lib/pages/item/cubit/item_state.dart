part of 'item_cubit.dart';

class ItemState extends Equatable {
  const ItemState({this.item, this.formModified = false});

  final LibraryItem item;
  final bool formModified;

  @override
  List<Object> get props => [item, formModified];

  ItemState copyWith({LibraryItem item, bool formModified}) {
    return ItemState(
        item: item ?? this.item,
        formModified: formModified ?? this.formModified);
  }
}

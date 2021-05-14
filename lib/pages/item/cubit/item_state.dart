part of 'item_cubit.dart';

class ItemState extends Equatable {
  const ItemState(this.item);

  final LibraryItem item;

  @override
  List<Object> get props => [item];
}

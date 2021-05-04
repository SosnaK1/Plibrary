part of 'new_item_cubit.dart';

class NewItemState extends Equatable {
  const NewItemState({
    this.selectedItemType = "Movies",
    this.title = const Title.pure(),
    this.status = FormzStatus.pure,
  });

  final String selectedItemType;
  final Title title;
  final FormzStatus status;

  static const itemTypes = ["Movies", "Series", "Books", "Games"];

  @override
  List<Object> get props => [selectedItemType, title, status];

  NewItemState copyWith(
      {String selectedItemType, Title title, FormzStatus status}) {
    return NewItemState(
        selectedItemType: selectedItemType ?? this.selectedItemType,
        title: title ?? this.title,
        status: status ?? this.status);
  }
}

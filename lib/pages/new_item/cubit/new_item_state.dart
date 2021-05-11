part of 'new_item_cubit.dart';

class NewItemState extends Equatable {
  const NewItemState({
    this.selectedItemType = "Movies",
    this.title = const Title.pure(),
    this.director = "",
    this.score = 0,
    this.status = FormzStatus.pure,
  });

  final String selectedItemType;
  final Title title;
  final String director;
  final double score;
  final FormzStatus status;

  static const itemTypes = ["Movies", "Series", "Books", "Games"];

  @override
  List<Object> get props => [selectedItemType, title, director, score, status];

  NewItemState copyWith(
      {String selectedItemType,
      Title title,
      String director,
      double score,
      String imagePath,
      FormzStatus status}) {
    return NewItemState(
        selectedItemType: selectedItemType ?? this.selectedItemType,
        title: title ?? this.title,
        director: director ?? this.director,
        score: score ?? this.score,
        status: status ?? this.status);
  }
}

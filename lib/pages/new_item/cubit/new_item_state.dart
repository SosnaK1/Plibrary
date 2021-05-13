part of 'new_item_cubit.dart';

class NewItemState extends Equatable {
  const NewItemState({
    this.selectedItemType,

    this.title = const Title.pure(),
    this.author = "",
    this.description = "",

    this.movieGenre = MovieGenre.Action,
    this.seriesGenre = SeriesGenre.Action,
    this.bookGenre = BookGenre.Adventure,
    this.gameGenre = GameGenre.Action_Adventure,

    this.finished = false,
    this.score = 0,
    this.status = FormzStatus.pure,
  });

  final String selectedItemType;

  final Title title;
  final String author;
  final String description;

  final MovieGenre movieGenre;
  final SeriesGenre seriesGenre;
  final BookGenre bookGenre;
  final GameGenre gameGenre;

  final bool finished;
  final double score;
  final FormzStatus status;

  static const itemTypes = ["Movies", "Series", "Books", "Games"];

  @override
  List<Object> get props => [
        selectedItemType,
        title,
        author,
        movieGenre,
        seriesGenre,
        bookGenre,
        gameGenre,
        description,
        finished,
        score,
        status
      ];

  NewItemState copyWith(
      {String selectedItemType,
      Title title,
      String author,
      String description,
      MovieGenre movieGenre,
      SeriesGenre seriesGenre,
      BookGenre bookGenre,
      GameGenre gameGenre,
      bool finished,
      double score,
      String imagePath,
      FormzStatus status}) {
    return NewItemState(
        selectedItemType: selectedItemType ?? this.selectedItemType,
        title: title ?? this.title,
        author: author ?? this.author,
        movieGenre: movieGenre ?? this.movieGenre,
        seriesGenre: seriesGenre ?? this.seriesGenre,
        bookGenre: bookGenre ?? this.bookGenre,
        gameGenre: gameGenre ?? this.gameGenre,
        description: description ?? this.description,
        finished: finished ?? this.finished,
        score: score ?? this.score,
        status: status ?? this.status);
  }
}

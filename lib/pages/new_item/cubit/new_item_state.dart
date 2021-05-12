part of 'new_item_cubit.dart';

class NewItemState extends Equatable {
  const NewItemState({
    this.selectedItemType,

    // Movie fields
    this.movieTitle = const Title.pure(),
    this.movieDirector = "",
    this.movieGenre = MovieGenre.Action,
    this.movieDescription = "",
    this.score = 0,
    this.status = FormzStatus.pure,
  });

  final String selectedItemType;

  final Title movieTitle;
  final String movieDirector;
  final MovieGenre movieGenre;
  final String movieDescription;

  final double score;
  final FormzStatus status;

  static const itemTypes = ["Movies", "Series", "Books", "Games"];

  @override
  List<Object> get props => [
        selectedItemType,

        movieTitle,
        movieDirector,
        movieGenre,
        movieDescription,
        
        score,
        status
      ];

  NewItemState copyWith(
      {String selectedItemType,
      Title movieTitle,
      String movieDirector,
      MovieGenre movieGenre,
      String movieDescription,
      double score,
      String imagePath,
      FormzStatus status}) {
    return NewItemState(
        selectedItemType: selectedItemType ?? this.selectedItemType,
        movieTitle: movieTitle ?? this.movieTitle,
        movieDirector: movieDirector ?? this.movieDirector,
        movieGenre: movieGenre ?? this.movieGenre,
        movieDescription: movieDescription ?? this.movieDescription,
        score: score ?? this.score,
        status: status ?? this.status);
  }
}

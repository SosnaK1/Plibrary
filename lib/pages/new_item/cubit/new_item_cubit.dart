import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models/movie.dart';
import 'package:plibrary/forms/models/models.dart';
import 'package:uuid/uuid.dart';

part 'new_item_state.dart';

class NewItemCubit extends Cubit<NewItemState> {
  NewItemCubit(this._databaseRepository, String initialItemType)
      : super(const NewItemState()) {
    if (NewItemState.itemTypes.contains(initialItemType)) {
      selectedItemTypeChanged(initialItemType);
    } else {
      selectedItemTypeChanged(NewItemState.itemTypes.first);
    }
  }

  final DatabaseRepository _databaseRepository;

  void selectedItemTypeChanged(String value) {
    emit(state.copyWith(selectedItemType: value));
  }

  void movieTitleChanged(String value) {
    final movieTitle = Title.dirty(value);
    emit(state.copyWith(
        movieTitle: movieTitle,
        status: Formz.validate([
          movieTitle,
        ])));
  }

  void movieDirectorChanged(String value) {
    emit(state.copyWith(movieDirector: value));
  }

  void movieGenreChanged(String newValue) {
    emit(state.copyWith(movieGenre: movieGenreFromString(newValue)));
  }

  void movieDescriptionChanged(String newValue) {
    emit(state.copyWith(movieDescription: newValue));
  }

  void seenChanged(bool newValue) {
    emit(state.copyWith(seen: newValue));
  }

  void scoreChanged(double value) {
    emit(state.copyWith(score: value));
  }

  Future<void> newItemSubmitted() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    var uuid = Uuid();

    try {
      if (state.selectedItemType == "Movies") {
        Movie movie = Movie(
            uuid: uuid.v1(),
            title: state.movieTitle.value,
            director: state.movieDirector,
            genre: state.movieGenre,
            description: state.movieDescription,
            seen: state.seen,
            score: state.score);

        await _databaseRepository.addNewMovie(movie);
      }

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

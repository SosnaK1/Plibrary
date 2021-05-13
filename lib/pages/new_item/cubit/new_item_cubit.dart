import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models/book.dart';
import 'package:plibrary/database_service/models/game.dart';
import 'package:plibrary/database_service/models/library_item.dart';
import 'package:plibrary/database_service/models/movie.dart';
import 'package:plibrary/database_service/models/series.dart';
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

  void titleChanged(String value) {
    final title = Title.dirty(value);
    emit(state.copyWith(
        title: title,
        status: Formz.validate([
          title,
        ])));
  }

  void authorChanged(String value) {
    emit(state.copyWith(author: value));
  }

  void movieGenreChanged(String newValue) {
    emit(state.copyWith(movieGenre: movieGenreFromString(newValue)));
  }

  void seriesGenreChanged(String newValue) {
    emit(state.copyWith(seriesGenre: seriesGenreFromString(newValue)));
  }

  void bookGenreChanged(String newValue) {
    emit(state.copyWith(bookGenre: bookGenreFromString(newValue)));
  }

  void gameGenreChanged(String newValue) {
    emit(state.copyWith(gameGenre: gameGenreFromString(newValue)));
  }

  void descriptionChanged(String newValue) {
    emit(state.copyWith(description: newValue));
  }

  void finishedChanged(bool newValue) {
    emit(state.copyWith(finished: newValue));
  }

  void scoreChanged(double value) {
    emit(state.copyWith(score: value));
  }

  Future<void> newItemSubmitted() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    var uuid = Uuid();

    try {
      LibraryItem newItem;

      if (state.selectedItemType == "Movies") {
        newItem = Movie(
            uuid: uuid.v1(),
            title: state.title.value,
            director: state.author,
            genre: state.movieGenre,
            description: state.description,
            finished: state.finished,
            score: state.score);
      } else if (state.selectedItemType == "Series") {
        newItem = Series(
            uuid: uuid.v1(),
            title: state.title.value,
            director: state.author,
            genre: state.seriesGenre,
            description: state.description,
            finished: state.finished,
            score: state.score);
      } else if (state.selectedItemType == "Books") {
        newItem = Book(
            uuid: uuid.v1(),
            title: state.title.value,
            author: state.author,
            genre: state.bookGenre,
            description: state.description,
            finished: state.finished,
            score: state.score);
      } else if (state.selectedItemType == "Games") {
        newItem = Game(
            uuid: uuid.v1(),
            title: state.title.value,
            studio: state.author,
            genre: state.gameGenre,
            description: state.description,
            finished: state.finished,
            score: state.score);
      }

      if (LibraryItem == null) throw Exception();

      await _databaseRepository.addNewItem(newItem);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}

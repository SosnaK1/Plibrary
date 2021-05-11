import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models/movie.dart';
import 'package:plibrary/forms/models/models.dart';
import 'package:uuid/uuid.dart';

part 'new_item_state.dart';

class NewItemCubit extends Cubit<NewItemState> {
  NewItemCubit(this._databaseRepository) : super(const NewItemState());

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

  void directorChanged(String value) {
    emit(state.copyWith(director: value));
  }

  void scoreChanged(double value) {
    emit(state.copyWith(score: value));
  }

  Future<void> newItemSubmitted() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    var uuid = Uuid();

    Movie movie = Movie(
        uuid: uuid.v1(),
        title: state.title.value,
        director: state.director,
        score: state.score);

    try {
      await _databaseRepository.addNewMovie(movie);

      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
